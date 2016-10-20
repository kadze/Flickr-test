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
#import "SAPOwnershipMacro.h"

static NSString * const kSAPSearchTag       = @"meteora";
static NSUInteger const kSAPItemsPrePage    = 20;

static NSString * const kSAPFlickrAPIKey    = @"be98568c74f05ca89feff5188454f5a4";

// Flickr API field keys
static NSString * const kSAPTitleKey        = @"title";
static NSString * const kSAPCommentKey      = @"description";
static NSString * const kSAPPhotosKey       = @"photos";
static NSString * const kSAPPhotoKey        = @"photo";
static NSString * const kSAPIDKey           = @"id";
static NSString * const kSAPFarmKey         = @"farm";
static NSString * const kSAPServerKey       = @"server";
static NSString * const kSAPSecretKey       = @"secret";
static NSString * const kSAPContentKey      = @"_content";

@interface SAPFlickrContext ()
@property (nonatomic, readonly) SAPArrayModel   *images;
@property (nonatomic, strong)   NSArray         *searchResult;

- (void)performBackgroundExecution;
- (void)search;
- (void)fillModelWithSearchResult;
- (void)loadDescriptions;
- (void)loadImages;

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
    SAPWeakify(self);
    SAPDispatchAsyncOnDefaultQueue(^{
        SAPStrongifyAndReturnIfNil(self);
        [self performBackgroundExecution];
    });
}

#pragma mark -
#pragma mark Private

- (void)performBackgroundExecution {
    [self search];
    [self fillModelWithSearchResult];
    [self loadDescriptions];
    [self loadImages];
    
    SAPModel *model = self.model;
    @synchronized (model) {
        model.state = kSAPModelStateDidFinishLoading;
    }
}

- (void)search {
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&per_page=%lu&format=json&nojsoncallback=1",
                           kSAPFlickrAPIKey,
                           kSAPSearchTag,
                           kSAPItemsPrePage];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.searchResult = [[json objectForKey:kSAPPhotosKey] objectForKey:kSAPPhotoKey];
            
            dispatch_semaphore_signal(semaphore);
        } else {
            NSLog(@"Error!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"my error with wrong flickr api use"
                                                                message:[error localizedDescription]
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            
            [alertView show];
            dispatch_semaphore_signal(semaphore);
        }
    }];
    
    [dataTask resume];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}

- (void)fillModelWithSearchResult {
    SAPArrayModel *images = self.images;
    for (NSDictionary *imageInfo in self.searchResult) {
        SAPFlickrImage *imageModel = [SAPFlickrImage new];
        imageModel.title = [imageInfo objectForKey:kSAPTitleKey];
        imageModel.ID = [imageInfo objectForKey:kSAPIDKey];
        imageModel.urlString = [NSString stringWithFormat:@"https://farm%@.static.flickr.com/%@/%@_%@_m.jpg",
                                [imageInfo objectForKey:kSAPFarmKey],
                                [imageInfo objectForKey:kSAPServerKey],
                                [imageInfo objectForKey:kSAPIDKey],
                                [imageInfo objectForKey:kSAPSecretKey]];
        
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
                imageModel.comment = [[[json objectForKey:kSAPPhotoKey] objectForKey:kSAPCommentKey] objectForKey:kSAPContentKey];
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
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    
    SAPArrayModel *images = self.images;
    for (NSUInteger index = 0; index < images.count; index++) {
        dispatch_group_enter(group);
        
        SAPDispatchSyncOnDefaultQueue(^{
            SAPFlickrImage *imageModel = images[index];
            NSURL *url = [NSURL URLWithString:imageModel.urlString];
            NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                UIImage *image = [UIImage imageWithData:data];
                imageModel.image = image;
                
                dispatch_group_leave(group);
            }];
            
            [task resume];
        });
    }
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
}

@end
