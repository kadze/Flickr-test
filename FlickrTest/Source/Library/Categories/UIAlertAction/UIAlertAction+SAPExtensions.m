//
//  UIAlertAction+VOI.m
//  VIPorbit
//
//  Created by Andrey on 7/28/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "UIAlertAction+SAPExtensions.h"

static NSString * const kSAPOKTitle = @"Cancel";
static NSString * const kSAPCancelTitle = @"Cancel";


@implementation UIAlertAction (SAPExtensions)

#pragma mark -
#pragma mark Class Methods

+ (instancetype)defaultActionWithTitle:(NSString *)title
                               handler:(void (^)(UIAlertAction * _Nonnull))handler
{
    return [self actionWithTitle:NSLocalizedString(title, nil) style:UIAlertActionStyleDefault handler:handler];
}

+ (instancetype)cancelAction {
    return [self cancelActionWithTitle:kSAPCancelTitle handler:nil];
}
+ (instancetype)OKAction {
    return [self cancelActionWithTitle:kSAPOKTitle handler:nil];
}

+ (instancetype)cancelActionWithTitle:(NSString *)title
                               handler:(void (^)(UIAlertAction * _Nonnull))handler
{
    return [self actionWithTitle:NSLocalizedString(title, nil) style:UIAlertActionStyleCancel handler:handler];
}

+ (instancetype)destructiveActionWithTitle:(NSString *)title
                               handler:(void (^)(UIAlertAction * _Nonnull))handler
{
    return [self actionWithTitle:NSLocalizedString(title, nil) style:UIAlertActionStyleDestructive handler:handler];
}

@end
