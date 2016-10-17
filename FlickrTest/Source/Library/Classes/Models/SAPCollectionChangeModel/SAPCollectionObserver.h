//
//  SAPArrayModelObserver.h
//  IOSProject
//
//  Created by S A P on 2/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SAPCollectionChangeModel;
@class SAPArrayModel;

@protocol SAPCollectionObserver <NSObject>

@optional
- (void)collection:(SAPArrayModel *)arrayModel didChangeWithModel:(SAPCollectionChangeModel *)changeModel;

@end
