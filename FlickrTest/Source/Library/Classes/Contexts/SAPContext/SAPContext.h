//
//  SAPContext.h
//  IOSProject
//
//  Created by SAP on 3/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <Foundation/NSObject.h>

@class FBSDKGraphRequest;

@interface SAPContext : NSObject
@property (nonatomic, strong) id model;

+ (instancetype)contextWithModel:(id)model;

- (instancetype)initWithModel:(id)model;
- (void)execute;
- (BOOL)shouldLoadWithState:(NSInteger)state;

//this methods should be overriden in subclasses
- (void)cancel;
- (void)stateUnsafeLoad;

@end
