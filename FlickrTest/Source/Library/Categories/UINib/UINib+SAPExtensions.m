//
//  UINib+SAPextensions.m
//  IOSProject
//
//  Created by S A P on 2/9/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "UINib+SAPextensions.h"

@implementation UINib (SAPextensions)

#pragma mark -
#pragma mark Class methods

+ (UINib *)nibWithClass:(Class)aClass {
    return [self nibWithClass:aClass bundle:nil];
}

+ (UINib *)nibWithClass:(Class)aClass bundle:(NSBundle *)bundle {
    return [self nibWithNibName:NSStringFromClass(aClass) bundle:bundle];
}

+ (id)objectWithClass:(Class)aClass {
    return [self objectWithClass:aClass owner:nil];
}

+ (id)objectWithClass:(Class)aClass owner:(id)owner {
    return [self objectWithClass:aClass owner:owner options:nil];
}

+ (id)objectWithClass:(Class)aClass owner:(id)owner options:(NSDictionary *)options {
    return [[self nibWithClass:aClass] objectWithClass:aClass owner:owner options:options];
}

#pragma mark -
#pragma mark Public methods

- (id)objectWithClass:(Class)aClass {
    return [self objectWithClass:aClass owner:nil];
}

- (id)objectWithClass:(Class)aClass owner:(id)owner {
    return [self objectWithClass:aClass owner:owner options:nil];
}

- (id)objectWithClass:(Class)aClass owner:(id)owner options:(NSDictionary *)options {
    NSArray *objects = [self instantiateWithOwner:owner options:options];
    for (id object in objects) {
        if ([object isMemberOfClass:aClass]) {
            return object;
        }
    }
    
    return nil;
}

@end
