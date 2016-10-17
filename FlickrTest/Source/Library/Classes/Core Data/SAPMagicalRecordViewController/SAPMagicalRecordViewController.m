//
//  SAPMagicalRecordViewController.m
//  ToDoList
//
//  Created by Andrey on 5/14/16.
//  Copyright © 2016 Andrey. All rights reserved.
//
#import <MagicalRecord/MagicalRecord.h>

#import "SAPMagicalRecordViewController.h"
#import "SAPTableViewCell.h"

#import "UIAlertController+SAPExtensions.h"
#import "UITableView+SAPExtensions.h"

#import "SAPModelView.h"

static NSString * const kSAPCacheFormatString = @"%@Cache";

@interface SAPMagicalRecordViewController ()
@property (nonatomic, readonly) NSString *cacheName;

- (void)configureCell:(UITableViewCell<SAPModelView> *)cell atIndexPath:(NSIndexPath *)indexPath;

@end

@implementation SAPMagicalRecordViewController

#pragma mark -
#pragma mark Accessors

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController) {
        return _fetchedResultsController;
    }
    
    NSManagedObjectContext *defaultContext = [NSManagedObjectContext MR_defaultContext];
    NSFetchRequest *request = [[self entityClass] MR_requestAllInContext:defaultContext];
    [request setSortDescriptors:[self sortDescriptors]];
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                    managedObjectContext:defaultContext
                                                                      sectionNameKeyPath:[self sectionNameKeyPath]
                                                                               cacheName:[self cacheName]];
    
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}

- (NSString *)cacheName {
    return [NSString stringWithFormat:kSAPCacheFormatString, NSStringFromClass([self entityClass])];
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [NSFetchedResultsController deleteCacheWithName:[self cacheName]];
    
    NSError *error = nil;
    [self.fetchedResultsController performFetch:&error];
    if (error) {
        [UIAlertController showWithError:error viewController:self];
    }
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.fetchedResultsController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.fetchedResultsController.sections objectAtIndex:section] numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SAPTableViewCell<SAPModelView> *cell = [tableView cellWithClass:[self cellClass]];
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

-   (void)tableView:(UITableView *)tableView
 commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
  forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObject *model = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext * localContext) {
            NSManagedObject *localModel = [model MR_inContext:localContext];
            [localModel MR_deleteEntity];
        }];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        //createEntityAndSave
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSFetchedResultsController *controller = self.fetchedResultsController;
    if ([[controller sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[controller sections] objectAtIndex:section];
        return [sectionInfo name];
    } else
        return nil;
}

#pragma mark -
#pragma mark NSFetchedResultsControllerDelegate

- (void)    controller:(NSFetchedResultsController *)controller
       didChangeObject:(id)anObject
           atIndexPath:(NSIndexPath *)indexPath
         forChangeType:(NSFetchedResultsChangeType)type
          newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath]
                    atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)    controller:(NSFetchedResultsController *)controller
      didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
               atIndex:(NSUInteger)sectionIndex
         forChangeType:(NSFetchedResultsChangeType)type
{
    if (NSFetchedResultsChangeInsert == type) {
        [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                      withRowAnimation:UITableViewRowAnimationFade];
    } else if (NSFetchedResultsChangeDelete == type) {
        [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                      withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

#pragma mark -
#pragma mark Public

- (Class)cellClass {
    return Nil;
}

- (Class)entityClass {
    return Nil;
}

- (NSString *)sectionNameKeyPath {
    return nil;
}

- (NSArray *)sortDescriptors {
    return nil;
}

#pragma mark -
#pragma mark Private

- (void)configureCell:(UITableViewCell<SAPModelView> *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSManagedObject *model = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [cell fillWithModel:model];
}

@end
