//
//  SAPWeakReference.m
//  MacCourse
//
//  Created by S A P on 12/11/15.
//  Copyright © 2015 Yosemite Retail. All rights reserved.
//
#import "SAPAssignReference.h"

@interface SAPAssignReference ()
@property (nonatomic, weak) id target;

@end

@implementation SAPAssignReference

@synthesize target = _target;

@end
