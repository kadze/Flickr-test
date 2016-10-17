//
//  SAPDispatchOnceMacro.h
//  IOSProject
//
//  Created by SAP on 4/3/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#define SAPDispatchOnce(block) \
    do { \
        static dispatch_once_t onceToken; \
        dispatch_once(&onceToken, block); \
    } while(0);
