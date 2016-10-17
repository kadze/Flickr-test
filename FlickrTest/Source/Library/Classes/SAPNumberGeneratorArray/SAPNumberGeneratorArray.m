//
//  NSNumberGeneratorArray.m
//  MacCourse
//
//  Created by S A P on 1/9/16.
//  Copyright © 2016 Yosemite Retail. All rights reserved.
//

#import "SAPNumberGeneratorArray.h"

@interface SAPNumberGeneratorArray ()
@property (nonatomic, assign) NSRange range;

@end

@implementation SAPNumberGeneratorArray

#pragma mark -
#pragma mark Class Methods

+ (instancetype)arrayWithRange:(NSRange)range {
    SAPNumberGeneratorArray *result = [self new];
    result.range = range;
    
    return result;
}

#pragma mark -
#pragma mark NSArray Methods

- (id)objectAtIndex:(NSUInteger)index {
    return @(self.range.location + index);
}

- (NSUInteger)count {
    return self.range.length;
}

@end
