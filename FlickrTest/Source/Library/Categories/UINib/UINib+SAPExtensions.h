//
//  UINib+SAPextensions.h
//  IOSProject
//
//  Created by S A P on 2/9/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <UIKit/UINib.h>

@interface UINib (SAPextensions)

+ (UINib *)nibWithClass:(Class)aClass;
+ (UINib *)nibWithClass:(Class)aClass bundle:(NSBundle *)bundle;

+ (id)objectWithClass:(Class)aClass;
+ (id)objectWithClass:(Class)aClass owner:(id)owner;
+ (id)objectWithClass:(Class)aClass owner:(id)owner options:(NSDictionary *)options;

- (id)objectWithClass:(Class)aClass;
- (id)objectWithClass:(Class)aClass owner:(id)owner;
- (id)objectWithClass:(Class)aClass owner:(id)owner options:(NSDictionary *)options;

@end
