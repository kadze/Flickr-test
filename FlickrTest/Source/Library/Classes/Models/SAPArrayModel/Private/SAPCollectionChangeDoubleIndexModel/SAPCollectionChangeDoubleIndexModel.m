//
//  SAPCollectionChangeDoubleIndexModel.m
//  IOSProject
//
//  Created by S A P on 2/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPCollectionChangeDoubleIndexModel.h"

@interface SAPCollectionChangeDoubleIndexModel ()
@property (nonatomic, assign) NSUInteger toIndex;

@end

@implementation SAPCollectionChangeDoubleIndexModel

#pragma mark -
#pragma mark Class methods

+ (instancetype)modelWithChangeType:(NSUInteger)changeType
                    index:(NSUInteger)fromIndex
                  toIndex:(NSUInteger)toIndex
{
    SAPCollectionChangeDoubleIndexModel *model = [self modelWithChangeType:changeType index:fromIndex];
    model.toIndex = toIndex;
    
    return model;
}

@end
