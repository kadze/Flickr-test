//
//  SAPTableViewController.h
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <UIKit/UITableView.h>

#import "SAPViewController.h"
#import "SAPCollectionObserver.h"

@class SAPArrayModel;
@class SAPArrayModelChangeModel;
@class SAPActivityIndicator;

@interface SAPArrayViewController : SAPViewController <
    UITableViewDelegate,
    UITableViewDataSource,
    SAPCollectionObserver
>

@property (nonatomic, strong)   SAPArrayModel *items;
@property (nonatomic, readonly) SAPContext    *itemsContext; //property getter should be overriden in subclasses
@property (nonatomic, readonly) UITableView   *tableView; //property getter should be overriden in subclasses

+ (Class)cellClass;

@end
