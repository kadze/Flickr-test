//
//  SAPFlickrContext.m
//  FlickrTest
//
//  Created by ASH on 10/19/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPFlickrContext.h"

#import "SAPModel.h"

@implementation SAPFlickrContext

#pragma mark -
#pragma mark Public

- (void)stateUnsafeLoad {
    SAPModel *model = self.model;
    @synchronized (model) {
        model.state = kSAPModelStateDidFinishLoading;
    }
}

@end
