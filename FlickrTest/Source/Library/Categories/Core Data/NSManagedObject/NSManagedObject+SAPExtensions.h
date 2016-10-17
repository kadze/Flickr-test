//
//  NSManagedObject+SAPExtensions.h
//  IOSProject
//
//  Created by Andrey on 4/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (SAPExtensions)

- (void)setCustomValue:(id)value forKey:(NSString *)key;
- (id)customValueForKey:(NSString *)key;

- (void)addCustomValue:(id)value inMutableSetForKey:(NSString *)key;
- (void)removeCustomValue:(id)value inMutableSetForKey:(NSString *)key;

@end
