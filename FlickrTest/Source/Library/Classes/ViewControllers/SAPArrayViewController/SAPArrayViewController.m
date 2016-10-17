//
//  SAPTableViewController.m
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPArrayViewController.h"

#import "SAPTableViewCell.h"
#import "SAPArrayModel.h"
#import "SAPActivityIndicator.h"

#import "SAPDispatch.h"

#import "UINib+SAPextensions.h"
#import "UITableView+SAPExtensions.h"
#import "UITableView+SAPCollectionChangeModel.h"

#import "SAPModelView.h"

#import "SAPViewControllerMacro.h"

@interface SAPArrayViewController ()

- (id)cellClass;

@end

@implementation SAPArrayViewController

@dynamic itemsContext;
@dynamic tableView;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.items = nil;
}

#pragma mark -
#pragma mark Class Methods

+ (Class)cellClass {
    return Nil;
}

#pragma mark -
#pragma mark Accessors

- (void)setItems:(SAPArrayModel *)items {
    if (_items != items) {
        [_items removeObserver:self];
        _items = items;
        [_items addObserverObject:self];
        
        if (items) {
            self.context = self.itemsContext;
        }
    }
}

- (SAPContext *)itemsContext {
    return nil;
}

- (UITableView *)tableView {
    return nil;
}

#pragma mark-
#pragma mark View Lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.items load];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SAPTableViewCell<SAPModelView> *cell = [tableView cellWithClass:[self cellClass]];
    cell.model = self.items[indexPath.row];
    
    return cell;
}

#pragma mark -
#pragma mark SAPCollectionObserver

- (void)collection:(SAPArrayModel *)arrayModel
didChangeWithModel:(SAPCollectionChangeModel *)changeModel
{
    UITableView *tableView = self.tableView;
    [tableView updateWithCollectionChangeModel:changeModel];
}

#pragma mark -
#pragma mark Public

- (void)updateViewControllerWithModel:(id)model {
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark Private

- (id)cellClass {
    return [[self class] cellClass];
}

@end
