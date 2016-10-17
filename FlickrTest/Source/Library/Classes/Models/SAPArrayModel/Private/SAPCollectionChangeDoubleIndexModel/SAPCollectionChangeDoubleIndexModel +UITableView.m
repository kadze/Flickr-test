//
//  SAPCollectionChangeDoubleIndexModel+UITableView.m
//  IOSProject
//
//  Created by S A P on 2/18/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPCollectionChangeDoubleIndexModel+UITableView.h"

#import "UITableView+SAPExtensions.h"

@implementation SAPCollectionChangeDoubleIndexModel (UITableView)
- (void)updateTableView:(UITableView *)tableView {
    SAPArrayIndexChangeType changeType = self.changeType;
    
    [tableView updateWithBlock:^(UITableView *object) {
        switch (changeType) {
            case kSAPChangeTypeObjectExchanged:
                //
                break;
                
            case kSAPChangeTypeObjectMoved:
                //
                break;
                
            default:
                break;
        }
    }];
}
@end
