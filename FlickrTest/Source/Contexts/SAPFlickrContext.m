//
//  SAPFlickrContext.m
//  FlickrTest
//
//  Created by ASH on 10/19/16.
//  Copyright © 2016 SAP. All rights reserved.
//
#import <UIkit/UIImage.h>

#import "SAPFlickrContext.h"

#import "SAPFlickrImage.h"
#import "SAPModel.h"
#import "SAPArrayModel.h"

#import "UIAlertController+SAPExtensions.h"

#import "SAPDispatch.h"
#import "SAPOwnershipMacro.h"

static NSString * const kSAPSearchTag       = @"sunset";
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
static NSString * const kSAPOwnerKey        = @"owner";
static NSString * const kSAPRealNameKey     = @"realname";

@interface SAPFlickrContext ()
@property (nonatomic, readonly) SAPArrayModel   *images;
@property (nonatomic, readonly) NSURLSession    *session;
@property (nonatomic, strong)   NSArray         *searchResult;

- (void)performBackgroundExecution;
- (void)search;
- (void)fillModelWithSearchResult;
- (void)loadDetails;
- (void)loadImages;

@end

@implementation SAPFlickrContext

@dynamic images, session;

#pragma mark -
#pragma mark Accessors

- (SAPArrayModel *)images {
    return self.model;
}

- (NSURLSession *)session {
    static NSURLSession *session = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    });
    
    return session;
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
    [self loadDetails];
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
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.searchResult = [[json objectForKey:kSAPPhotosKey] objectForKey:kSAPPhotoKey];
        } else {
            SAPDispatchAsyncOnMainQueue(^{
                [UIAlertController presentWithError:error];
            });
        }
        
        dispatch_semaphore_signal(semaphore);
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

- (void)loadDetails {
    dispatch_group_t group = dispatch_group_create();
    
    SAPArrayModel *images = self.images;
    NSURLSession *session = self.session;
    for (NSUInteger index = 0; index < images.count; index++) {
        SAPFlickrImage *imageModel = images[index];
        
        dispatch_group_enter(group);
        NSString *urlString = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.getInfo&api_key=%@&photo_id=%@&format=json&nojsoncallback=1" , kSAPFlickrAPIKey, imageModel.ID];
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (!error) {
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                imageModel.comment = [[[json objectForKey:kSAPPhotoKey] objectForKey:kSAPCommentKey] objectForKey:kSAPContentKey];
                imageModel.author = [[[json objectForKey:kSAPPhotoKey] objectForKey:kSAPOwnerKey] objectForKey:kSAPRealNameKey];
            } else {
                SAPDispatchAsyncOnMainQueue(^{
                    [UIAlertController presentWithError:error];
                });
            }
            
            dispatch_group_leave(group);
        }];
        
        [dataTask resume];
    }
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
}

- (void)loadImages {
    dispatch_group_t group = dispatch_group_create();
    
    NSURLSession *session = self.session;
    
    SAPArrayModel *images = self.images;
    for (NSUInteger index = 0; index < images.count; index++) {
        dispatch_group_enter(group);
        
        SAPDispatchAsyncOnDefaultQueue(^{
            SAPFlickrImage *imageModel = images[index];
            NSURL *url = [NSURL URLWithString:imageModel.urlString];
            NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if (!error) {
                    UIImage *image = [UIImage imageWithData:data];
                    imageModel.image = image;
                } else {
                    SAPDispatchAsyncOnMainQueue(^{
                        [UIAlertController presentWithError:error];
                    });
                }
                
                dispatch_group_leave(group);
            }];
            
            [task resume];
        });
    }
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
}

@end
