//
//  SAPCompareMacro.h
//  IOSProject
//
//  Created by SAP on 4/3/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#define SAPNilIfNSNull(value) \
    ([NSNull new] == value) ? nil : value

#define SAPNSNullIfNil(value) \
    nil == value ? [NSNull new] : value
