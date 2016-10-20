//
//  SAPFlickrContext.m
//  FlickrTest
//
//  Created by ASH on 10/19/16.
//  Copyright © 2016 SAP. All rights reserved.
//
#import <UIkit/UIImage.h>

#import "SAPFlickrContext.h"

#import "AFNetworking.h"
#import "SAPFlickrImage.h"
#import "SAPModel.h"
#import "SAPArrayModel.h"

#import "SAPDispatch.h"

static NSInteger const TEMPITEMSCOUNT = 50;
static NSString * const kSAPFlickrAPIKey    = @"be98568c74f05ca89feff5188454f5a4";
static NSString * const kSAPSearchTag       = @"Kharkov";
static NSString * const kSAPTitleKey        = @"title";
static NSString * const kSAPCommentKey      = @"description";

@interface SAPFlickrContext ()
@property (nonatomic, readonly) SAPArrayModel *images;
@property (nonatomic, strong) NSArray *searchResult;

@end

@implementation SAPFlickrContext

#pragma mark -
#pragma mark Accessors

- (SAPArrayModel *)images {
    return self.model;
}

#pragma mark -
#pragma mark Public

- (void)stateUnsafeLoad {
    [self search];
    [self fillModelWithSearchResult];
    [self loadDescriptions];
//    [self loadImages];
    
    //temporary code
//    SAPArrayModel *images = self.model;
//    UIImage *image = [UIImage imageNamed:@"orbit"];
//    NSString *shortTestComment = @"My short test comment";
//    NSString *testComment = @"My test comment bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla ";
//    for (NSUInteger index = 0; index < TEMPITEMSCOUNT; index++) {
//        SAPFlickrImage *flickrImage = [SAPFlickrImage new];
//        flickrImage.image = image;
//        if (index % 3 == 0) {
//            flickrImage.comment = shortTestComment;
//        } else {
//            flickrImage.comment = testComment;
//        }
//        
//        flickrImage.title = @"My test caption";
//        [images addObject:flickrImage];
//    }
//    
//    SAPModel *model = images;
//    self.model = model;
    
    
//    SAPModel *model = self.model;
//
//    @synchronized (model) {
//        model.state = kSAPModelStateDidFinishLoading;
//    }
}

- (void)search {
//    dispatch_group_t searchGroup = dispatch_group_create();
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&per_page=10&format=json&nojsoncallback=1", kSAPFlickrAPIKey, kSAPSearchTag];
    NSURL *url = [NSURL URLWithString:urlString];
    
//    dispatch_group_enter(searchGroup);
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.searchResult = [[json objectForKey:@"photos"] objectForKey:@"photo"];
            
//            dispatch_group_leave(searchGroup);
            dispatch_semaphore_signal(semaphore);
        } else {
            NSLog(@"Error!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"my error with wrong flickr api use"
                                                                message:[error localizedDescription]
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            
            [alertView show];
//            dispatch_group_leave(searchGroup);
            dispatch_semaphore_signal(semaphore);
        }
    }];
    
    [dataTask resume];
    
//    dispatch_group_wait(searchGroup, DISPATCH_TIME_FOREVER);
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}

- (void)fillModelWithSearchResult {
    SAPArrayModel *images = self.images;
    for (NSDictionary *imageInfo in self.searchResult) {
        SAPFlickrImage *imageModel = [SAPFlickrImage new];
        imageModel.title = [imageInfo objectForKey:kSAPTitleKey];
        imageModel.ID = [imageInfo objectForKey:@"id"];
        imageModel.urlString = [NSString stringWithFormat:@"https://farm%@.static.flickr.com/%@/%@_%@_m.jpg",
                                [imageInfo objectForKey:@"farm"],
                                [imageInfo objectForKey:@"server"],
                                [imageInfo objectForKey:@"id"],
                                [imageInfo objectForKey:@"secret"]];
        
        //
        UIImage *image = [UIImage imageNamed:@"orbit"];
        imageModel.image = image;
        //
        
        [images addObject:imageModel];
    }
}

- (void)loadDescriptions {
    dispatch_group_t group = dispatch_group_create();
    
    SAPArrayModel *images = self.images;
    for (NSUInteger index = 0; index < images.count; index++) {
        SAPFlickrImage *imageModel = images[index];
        
        dispatch_group_enter(group);
        NSString *urlString = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.getInfo&api_key=%@&photo_id=%@&format=json&nojsoncallback=1" , kSAPFlickrAPIKey, imageModel.ID];
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (!error) {
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                imageModel.comment = [[[json objectForKey:@"photo"] objectForKey:kSAPCommentKey] objectForKey:@"_content"];
                dispatch_group_leave(group);
            } else {
                NSLog(@"Error!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
            }
        }];
        
        [dataTask resume];
    }
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
}

- (void)loadImages {
    dispatch_group_t group = dispatch_group_create();
    
    SAPArrayModel *images = self.images;
    for (NSUInteger index = 0; index < images.count; index++) {
        SAPFlickrImage *imageModel = images[index];
        
        dispatch_group_enter(group);
    
        NSURL *url = [NSURL URLWithString:imageModel.urlString];
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (!error) {
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                imageModel.comment = [[[json objectForKey:@"photo"] objectForKey:kSAPCommentKey] objectForKey:@"_content"];
                dispatch_group_leave(group);
            } else {
                NSLog(@"Error!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
            }
        }];
        
        [dataTask resume];
    }
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
}

@end
