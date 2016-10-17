//
//  SAPDispatch.m
//  MacCourse
//
//  Created by S A P on 1/22/16.
//  Copyright © 2016 Yosemite Retail. All rights reserved.
//

#import "SAPDispatch.h"
#import <Foundation/Foundation.h>

#pragma mark -
#pragma mark Private Declarations

dispatch_queue_t getDefaultQueue(void);

#pragma mark -
#pragma mark Public Implementations

void SAPDispatchAsyncOnMainQueue(dispatch_block_t block) {
    dispatch_async(dispatch_get_main_queue(), block);
}

void SAPDispatchSyncOnMainQueue(dispatch_block_t block) {
    if (!block) {
        return;
    }
    
    if ([NSThread mainThread] == [NSThread currentThread]) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

void SAPDispatchAsyncOnDefaultQueue(dispatch_block_t block) {
    dispatch_async(getDefaultQueue(), block);
}

//never call this method from a task, that is executing in the same queue that you are planning to pass the function
void SAPDispatchSyncOnDefaultQueue(dispatch_block_t block) {
    dispatch_sync(getDefaultQueue(), block);
}

#pragma mark-
#pragma mark Private Implementations

dispatch_queue_t getDefaultQueue(void) {
    return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
}
