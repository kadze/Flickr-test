//
//  NSArray+SAPJSONArray.m
//  IOSProject
//
//  Created by SAP on 4/3/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "NSArray+SAPJSONArray.h"

@implementation NSArray (SAPJSONArray)

- (instancetype)JSONRepresentation {
    NSMutableArray *array = [NSMutableArray new];
    for (id object in self) {
        id representation = [object JSONRepresentation];
        if (representation) {
            [array addObject:representation];
        }
    }
    
    return [[self class] arrayWithArray:array];
}

@end
