//
//  SAPIdentifiableManagedObject.h
//  IOSProject
//
//  Created by Andrey on 4/25/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPManagedObject.h"

@interface SAPIdentifiableManagedObject : SAPManagedObject
@property (nonatomic, strong) NSString *iD;

+ (id)managedObjectWithID:(NSString *)iD
                         entityName:(NSString *)entityName;

@end
