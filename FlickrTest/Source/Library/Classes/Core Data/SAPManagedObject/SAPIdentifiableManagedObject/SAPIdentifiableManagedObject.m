//
//  SAPIdentifiableManagedObject.m
//  IOSProject
//
//  Created by Andrey on 4/25/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPIdentifiableManagedObject.h"

#import "SAPCoreDataController.h"

@implementation SAPIdentifiableManagedObject

@dynamic iD;

#pragma mark -
#pragma mark Class Methods

+ (id)managedObjectWithID:(NSString *)iD
                         entityName:(NSString *)entityName
{
    SAPIdentifiableManagedObject *result = nil;
    NSError *error = nil;
    
    NSManagedObjectContext *managedObjectContext = [SAPCoreDataController sharedManagedObjectContext];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"iD == %@", iD];
    request.predicate = predicate;
    
    NSArray *results = [managedObjectContext executeFetchRequest:request error:&error];
    
    if (!results) {
        return nil;
    }
    
    if (results.count == 0) {
        result = [NSEntityDescription insertNewObjectForEntityForName:entityName
                                               inManagedObjectContext:managedObjectContext];
        result.iD = iD;
        
        if (![managedObjectContext save:&error]) {
            return nil;
        }
        
    } else {
        result = results.firstObject;
    }
    
    return result;
}

@end
