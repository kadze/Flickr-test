//
//  UITableView+SAPCollectionChangeModel.h
//  IOSProject
//
//  Created by S A P on 2/17/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <UIKit/UITableView.h>

@class SAPCollectionChangeModel;

@interface UITableView (SAPCollectionChangeModel)

- (void)updateWithCollectionChangeModel:(SAPCollectionChangeModel *)model;

@end
