//
//  NSObject+SAPAssociatedObjects.h
//  IOSProject
//
//  Created by S A P on 2/29/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

typedef NS_ENUM(NSUInteger, SAPObjCAssociationPolicy)  {
    kSAPWeakPolicy = OBJC_ASSOCIATION_ASSIGN,
    kSAPNonatomicStrongPolicy = OBJC_ASSOCIATION_RETAIN_NONATOMIC,
    kSAPNonatomicCopyPolicy = OBJC_ASSOCIATION_COPY_NONATOMIC,
    kSAPStrongPolicy = OBJC_ASSOCIATION_RETAIN,
    kSAPCopyPolicy = OBJC_ASSOCIATION_COPY
};

@interface NSObject (SAPAssociatedObjects)

- (void)setAssociatedtObject:(id)value forKey:(void *)key withOption:(SAPObjCAssociationPolicy)option;
- (id)associatedObjectForKey:(void *)key;

@end
