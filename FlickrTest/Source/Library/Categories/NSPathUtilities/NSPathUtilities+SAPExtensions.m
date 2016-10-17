//
//  NSPathUtilities+SAPExtensions.m
//  IOSProject
//
//  Created by S A P on 3/1/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "NSPathUtilities+SAPExtensions.h"

NSString *NSSearchPathForDirectory(NSSearchPathDirectory directory) {
    return [NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES) firstObject];
}