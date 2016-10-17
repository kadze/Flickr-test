//
//  SAPReference.m
//  MacCourse
//
//  Created by S A P on 12/11/15.
//  Copyright © 2015 Yosemite Retail. All rights reserved.
//

#import "SAPReference.h"

@implementation SAPReference

@dynamic target;

#pragma mark -
#pragma mark Initializations & Deallications

- (instancetype)initWithTarget:(id)object {
    if (nil == object) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        self.target = object;
    }
    
    return self;
}

#pragma mark -
#pragma mark NSCopying

- (id)copyWithZone:(NSZone *)zone {
    return [[[self class] alloc] initWithTarget:self.target];
}

#pragma mark -
#pragma mark NSObject equality

- (NSUInteger)hash {
    return [self.target hash];
}

- (BOOL)isEqual:(SAPReference *)object {
    if (object == self) {
        return YES;
    }
    
    if (object.hash == self.hash && [object isMemberOfClass:[self class]]) {
        return [self isEqualToReference:object];
    }
    
    return NO;
}

- (BOOL)isEqualToReference:(SAPReference *)object {
    return object.target == self.target;
}

@end
