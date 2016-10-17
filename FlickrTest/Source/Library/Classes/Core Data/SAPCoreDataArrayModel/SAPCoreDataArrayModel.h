//
//  SAPCoreDataArrayModel.h
//  IOSProject
//
//  Created by Andrey on 4/25/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPArrayModel.h"

#import <CoreData/NSFetchedResultsController.h>

@interface SAPCoreDataArrayModel : SAPArrayModel <NSFetchedResultsControllerDelegate>
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

- (instancetype)initWithFetchedResultsControllerForContext:(NSManagedObjectContext *)context
                                                    entity:(NSEntityDescription *)entity;

//this method should be overriden in subclasses
- (NSArray *)fetchedResultsControllerSortDescriptors;

@end
