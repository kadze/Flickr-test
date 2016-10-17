//
//  SAPDispatch.h
//  MacCourse
//
//  Created by S A P on 1/22/16.
//  Copyright © 2016 Yosemite Retail. All rights reserved.
//
#import <dispatch/dispatch.h>

extern
void SAPDispatchAsyncOnMainQueue(dispatch_block_t block);

extern
void SAPDispatchSyncOnMainQueue(dispatch_block_t block);

extern
void SAPDispatchAsyncOnDefaultQueue(dispatch_block_t block);

extern
void SAPDispatchSyncOnDefaultQueue(dispatch_block_t block);
