//
//  SAPMacro.h
//  UIProject
//
//  Created by S A P on 1/28/16.
//  Copyright © 2016 Andrey Shevtsov. All rights reserved.
//
#define SAPViewPropertySynthesize(viewClass, propertyName) \
    @property (nonatomic, strong) viewClass *propertyName;

#define SAPViewGetterSynthesize(viewClass, propertyName) \
    - (viewClass *)propertyName { \
        if ([self isViewLoaded] && [self.view isKindOfClass:[viewClass class]]) { \
            return (viewClass *)self.view; \
        } \
    \
        return nil; \
    }

#define SAPViewControllerBaseViewProperty(controllerName, viewClass, propertyName) \
    \
    @interface controllerName (__SAPViewControllerProperty__##controllerName##__##viewClass##__##propertyName) \
    SAPViewPropertySynthesize(viewClass, propertyName) \
    \
    @end \
    \
    @implementation controllerName (__SAPViewControllerProperty__##controllerName##__##viewClass##__##propertyName)  \
    \
    @dynamic propertyName; \
    \
    SAPViewGetterSynthesize(viewClass, propertyName) \
    \
    @end
