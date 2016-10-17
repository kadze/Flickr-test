//
//  SAPCollectionChangeIndexModel+UITableView.h
//  IOSProject
//
//  Created by S A P on 2/17/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPCollectionChangeIndexModel.h"

@class NSIndexPath;

@interface SAPCollectionChangeIndexModel (UITableView)
@property (nonatomic, readonly) NSIndexPath *indexPath;

@end
