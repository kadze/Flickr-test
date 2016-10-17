//
//  NSObject+SAPExtensions.m
//  IOSProject
//
//  Created by S A P on 3/1/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "NSObject+SAPExtensions.h"

#import "NSNumber+SAPExtentions.h"

@implementation NSObject (SAPExtensions)

#pragma mark -
#pragma mark Class Methods

+ (NSArray *)objectsWithCount:(NSUInteger)count {
    NSMutableArray *array = [NSMutableArray new];
    [@(count) times:^(NSNumber *value) {
        [array addObject:[self new]];
    }];
    
    return [array copy];
}

@end
