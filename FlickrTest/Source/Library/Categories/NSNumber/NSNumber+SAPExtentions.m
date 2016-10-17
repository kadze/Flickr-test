//
//  NSNumber+SAPExtentions.m
//  MacCourse
//
//  Created by S A P on 1/9/16.
//  Copyright © 2016 Yosemite Retail. All rights reserved.
//

#import "NSNumber+SAPExtentions.h"
#import "SAPNumberGeneratorArray.h"

@implementation NSNumber (SAPExtentions)

#pragma mark -
#pragma mark Public Methods

- (void)times:(void(^)(NSNumber *value))block {
    if (!block) {
        return;
    }
    
    NSArray *array = [SAPNumberGeneratorArray arrayWithRange:NSMakeRange(0, self.unsignedIntegerValue)];
    for (NSNumber *value in array) {
        block(value);
    }
}

@end
