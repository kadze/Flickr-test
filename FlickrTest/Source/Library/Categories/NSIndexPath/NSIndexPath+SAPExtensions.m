//
//  NSIndexPath+SAPExtensions.m
//  IOSProject
//
//  Created by S A P on 2/17/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "NSIndexPath+SAPExtensions.h"

#import <UIKit/UITableView.h>

@implementation NSIndexPath (SAPExtensions)

+ (instancetype)indexPathForRow:(NSUInteger)row {
    return [NSIndexPath indexPathForRow:row inSection:0];
}

@end
