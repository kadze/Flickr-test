//
//  SAPCacheableModel.h
//  IOSProject
//
//  Created by S A P on 3/6/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SAPCacheableModel <NSObject>
@optional
@property (nonatomic, readonly) BOOL      cached;
@property (nonatomic, readonly) NSString  *path;

- (void)save;
- (void)cleanCache;

@end
