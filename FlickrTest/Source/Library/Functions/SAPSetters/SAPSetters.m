//
//  SAPSetters.m
//  IOSProject
//
//  Created by Andrey on 4/15/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPSetters.h"

#import "SAPContext.h"

#pragma mark -
#pragma mark Public Implementations

void SAPContextIvarSetValue(SAPContext *__strong *ivar, id value) {
    if (*ivar != value) {
        [*ivar cancel];
        *ivar = value;
        [*ivar execute];
    }
}

