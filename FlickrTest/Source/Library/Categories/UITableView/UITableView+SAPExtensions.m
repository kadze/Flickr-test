//
//  UITableView+SAPExtensions.m
//  IOSProject
//
//  Created by S A P on 2/10/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "UITableView+SAPExtensions.h"

#import "UINib+SAPExtensions.h"
#import "SAPTableViewCell.h"

@implementation UITableView (SAPExtensions)

- (id)cellWithClass:(Class)aClass {
    id cell = [self dequeueReusableCellWithIdentifier:NSStringFromClass(aClass)];
    if (!cell) {
        cell = [UINib objectWithClass:aClass];
    }
    
    return cell;
}

- (void)updateWithBlock:(void(^)(UITableView *))block {
    if (!block) {
        return;
    }
    
    [self beginUpdates];
    block(self);
    [self endUpdates];
}

@end
