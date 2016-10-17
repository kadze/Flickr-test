//
//  NSDictionary+SAPJSONDictionary.m
//  IOSProject
//
//  Created by SAP on 4/3/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "NSDictionary+SAPJSONDictionary.h"

@implementation NSDictionary (SAPJSONDictionary)

- (instancetype)JSONRepresentation {
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    for (id key in self) {
        id representation = [self[key] JSONRepresentation];
        if (representation) {
            dictionary[key] = representation;
        }
    }
    
    return [[self class] dictionaryWithDictionary:dictionary];
}

@end
