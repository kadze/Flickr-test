//
//  SAPFlickrLayoutAttributes.m
//  FlickrTest
//
//  Created by ASH on 10/18/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPFlickrLayoutAttributes.h"

@implementation SAPFlickrLayoutAttributes

#pragma mark -
#pragma mark Public

- (instancetype)copyWithZone:(NSZone *)zone {
    SAPFlickrLayoutAttributes *copy = [super copyWithZone:zone];
    copy.imageHeight = self.imageHeight;
    
    return copy;
}

- (BOOL)isEqual:(id)object {
    if ([object isMemberOfClass:[SAPFlickrLayoutAttributes class]]) {
        if (((SAPFlickrLayoutAttributes *)object).imageHeight == self.imageHeight ) {
            return [super isEqual:object];
        }
    }
    
    return NO;
}

@end
