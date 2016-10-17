//
//  SAPMagicalRecordViewController.h
//  ToDoList
//
//  Created by Andrey on 5/14/16.
//  Copyright © 2016 Andrey. All rights reserved.
//
#import <UIKit/UITableView.h>
#import <CoreData/NSFetchedResultsController.h>

#import "SAPViewController.h"

@interface SAPMagicalRecordViewController : SAPViewController <
    UITableViewDataSource,
    UITableViewDelegate,
    NSFetchedResultsControllerDelegate
>

@property (nonatomic, strong)   NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, readonly) UITableView                *tableView;

//these methods should be overriden in subclasses
- (Class)cellClass;
- (Class)entityClass;
- (NSString *)sectionNameKeyPath;
- (NSArray *)sortDescriptors;

@end
