//
//  SAPCollectionChangeIndexModel+UITableView.m
//  IOSProject
//
//  Created by S A P on 2/17/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPCollectionChangeIndexModel+UITableView.h"

#import <UIKit/UITableView.h>

#import "NSIndexPath+SAPExtensions.h"
#import "UITableView+SAPExtensions.h"

@implementation SAPCollectionChangeIndexModel (UITableView)

@dynamic indexPath;

- (NSIndexPath *)indexPath {
    return [NSIndexPath indexPathForRow:self.index];
}

- (void)updateTableView:(UITableView *)tableView {
    NSIndexPath *indexPath = self.indexPath;
    NSArray *indexPaths = @[indexPath];
    SAPArrayIndexChangeType changeType = self.changeType;
    
    [tableView updateWithBlock:^(UITableView *object) {
        switch (changeType) {
            case kSAPChangeTypeObjectAdded:
                [tableView insertRowsAtIndexPaths:indexPaths
                                 withRowAnimation:UITableViewRowAnimationTop];
                
                break;
                
            case kSAPChangeTypeObjectInserted:
                [tableView insertRowsAtIndexPaths:indexPaths
                                 withRowAnimation:UITableViewRowAnimationTop];
                break;
                
            case kSAPChangeTypeObjectReplaced:
                [tableView reloadRowsAtIndexPaths:indexPaths
                                 withRowAnimation:UITableViewRowAnimationMiddle];
                break;
                
            case kSAPChangeTypeObjectRemoved:
                [tableView deleteRowsAtIndexPaths:indexPaths
                                 withRowAnimation:UITableViewRowAnimationFade];
                break;
                
            case kSAPChangeTypeObjectUpdated:
                [tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
                
                break;
                
            default:
                break;
        }
    }];
    
    if (kSAPChangeTypeObjectAdded == changeType) {
        [tableView scrollToRowAtIndexPath:indexPath
                         atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

@end
