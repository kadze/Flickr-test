//
//  SAPCoreDataArrayModel.m
//  IOSProject
//
//  Created by Andrey on 4/25/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPCoreDataArrayModel.h"

#import <CoreData/NSEntityDescription.h>
#import <UIKit/UITableView.h>

@implementation SAPCoreDataArrayModel

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithFetchedResultsControllerForContext:(NSManagedObjectContext *)context
                                                    entity:(NSEntityDescription *)entity
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    NSFetchRequest *fetchedRequest = [NSFetchRequest fetchRequestWithEntityName:entity.managedObjectClassName];
    fetchedRequest.sortDescriptors = [self fetchedResultsControllerSortDescriptors];
    
    NSFetchedResultsController *fetchedController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchedRequest
                                                                                        managedObjectContext:context
                                                                                          sectionNameKeyPath:nil cacheName:nil];
    
    self.fetchedResultsController = fetchedController;
    fetchedController.delegate = self;
    NSError *error;
    [fetchedController performFetch:&error];
    
    return self;
}

#pragma mark -
#pragma mark NSFetchedResultsControllerDelegate

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(nullable NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(nullable NSIndexPath *)newIndexPath
{
    switch (type) {
        case NSFetchedResultsChangeInsert: {
            [self performBlockWithNotification:^{
                [self addObject:anObject];
            }];
        }
            
            break;
         
        case NSFetchedResultsChangeUpdate: {
            [self performBlockWithNotification:^{
                [self updateObjectAtIndex:indexPath.row];
            }];
        }
            
            break;
            
        case NSFetchedResultsChangeDelete: {
            [self performBlockWithNotification:^{
                [self removeObjectAtIndex:indexPath.row];
            }];
        }
            
            break;
        
        case NSFetchedResultsChangeMove: {
            [self performBlockWithNotification:^{
                [self moveObjectFromIndex:indexPath.row toIndex:newIndexPath.row];
            }];
        }
            
            break;
            
        default:
            break;
    }

}

#pragma mark -
#pragma mark Public

- (NSArray *)fetchedResultsControllerSortDescriptors {
    return nil;
}

@end
