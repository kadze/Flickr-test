//
//  UITableView+SAPCollectionChangeModel.m
//  IOSProject
//
//  Created by S A P on 2/17/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "UITableView+SAPCollectionChangeModel.h"

#import "SAPCollectionChangeModel+UITableView.h"

@implementation UITableView (SAPCollectionChangeModel)

- (void)updateWithCollectionChangeModel:(SAPCollectionChangeModel *)model {
    [model updateTableView:self];
}

@end
