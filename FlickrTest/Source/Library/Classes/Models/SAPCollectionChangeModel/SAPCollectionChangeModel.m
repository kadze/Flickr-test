//
//  SAPCollectionChangeModel.m
//  IOSProject
//
//  Created by S A P on 2/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPCollectionChangeModel.h"

#import "SAPCollectionChangeIndexModel.h"
#import "SAPCollectionChangeDoubleIndexModel.h"

@interface SAPCollectionChangeModel ()
@property (nonatomic, assign) NSUInteger changeType;

@end

@implementation SAPCollectionChangeModel

#pragma mark-
#pragma mark Initializations and Deallocations

- (instancetype)initWithChangeType:(NSUInteger)changeType {
    self = [super init];
    if (self) {
        self.changeType = changeType;
    }
    
    return self;
}

#pragma mark-
#pragma mark Class methods

+ (instancetype)modelWithChangeType:(NSUInteger)changeType {
    return [[self alloc] initWithChangeType:changeType];
}

@end
