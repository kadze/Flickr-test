//
//  SAPCollectionChangeIndexModel.m
//  IOSProject
//
//  Created by S A P on 2/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPCollectionChangeIndexModel.h"

@interface SAPCollectionChangeIndexModel ()
@property (nonatomic, assign) NSUInteger index;

@end

@implementation SAPCollectionChangeIndexModel

#pragma mark -
#pragma mark Class methods

+ (instancetype)modelWithChangeType:(NSUInteger)changeType
                  index:(NSUInteger)index
{
    SAPCollectionChangeIndexModel *model = [super modelWithChangeType:changeType];
    model.index = index;
    
    return model;
}

@end
