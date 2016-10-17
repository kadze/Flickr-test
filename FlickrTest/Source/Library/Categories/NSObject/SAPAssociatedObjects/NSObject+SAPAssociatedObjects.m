//
//  NSObject+SAPAssociatedObjects.m
//  IOSProject
//
//  Created by S A P on 2/29/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "NSObject+SAPAssociatedObjects.h"

@implementation NSObject (SAPAssociatedObjects)

- (void)setAssociatedtObject:(id)value forKey:(void *)key withOption:(SAPObjCAssociationPolicy)option {
    objc_setAssociatedObject(self, key, value, (objc_AssociationPolicy)option);
}

- (id)associatedObjectForKey:(void *)key {
    return objc_getAssociatedObject(self, key);
}

@end
