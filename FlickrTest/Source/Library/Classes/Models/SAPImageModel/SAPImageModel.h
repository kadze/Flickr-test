//
//  SAPImageModel.h
//  IOSProject
//
//  Created by S A P on 3/3/16.
//  Copyright © 2016 SAP. All rights reserved.
//
#import <UIKit/UIImage.h>

#import "SAPModel.h"

#import "SAPCacheableModel.h"

@class SAPObjectCache;

@interface SAPImageModel : SAPModel <SAPCacheableModel>
@property (nonatomic, readonly) UIImage *image;
@property (nonatomic, copy, readonly) NSURL   *url;

+ (SAPObjectCache *)cache;

+ (instancetype)imageWithUrl:(NSURL *)url;

- (instancetype)initWithUrl:(NSURL *)url NS_DESIGNATED_INITIALIZER;

@end
