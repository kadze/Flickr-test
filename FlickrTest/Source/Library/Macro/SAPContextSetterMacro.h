//
//  SAPContextSetterMacro.h
//  IOSProject
//
//  Created by SAP on 4/10/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#define SAPContextSetter(contextClassName, ivar, setterName) \
- (void)setterName:(contextClassName *)context{ \
    if (ivar != context) { \
        [ivar cancel]; \
        ivar = context; \
        [context execute]; \
    } \
}