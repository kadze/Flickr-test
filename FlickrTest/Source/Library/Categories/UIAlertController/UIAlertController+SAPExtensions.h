//
//  UIAlertController+SAPExtensions.h
//  VIPorbit
//
//  Created by Oleg Korchytskyi on 8/17/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIAlertController (SAPExtensions)

+ (void)presentAlertControllerWithTitle:(nullable NSString *)title
                                message:(nullable NSString *)message; // with defaul OK button

+ (void)presentAlertControllerWithTitle:(nullable NSString *)title
                                message:(nullable NSString *)message
                      cancelButtonTitle:(nullable NSString *)cancelButtonTitle;

+ (void)presentAlertControllerWithTitle:(nullable NSString *)title
                                message:(nullable NSString *)message
                     primaryActionTitle:(nullable NSString *)primaryActionTitle
                                handler:(void (^ _Nullable)(UIAlertAction *action))handler
                      cancelButtonTitle:(nullable NSString *)cancelButtonTitle;
+ (void)presentAlertControllerWithTitle:(nullable NSString *)title
                                message:(nullable NSString *)message
                     primaryActionTitle:(nullable NSString *)primaryActionTitle
                                handler:(void (^ _Nullable)(UIAlertAction *action))handler
                   secondaryActionTitle:(nullable NSString *)secondaryActionTitle
                       secondaryHandler:(void (^ _Nullable)(UIAlertAction *action))secondaryHandler
                      cancelButtonTitle:(nullable NSString *)cancelButtonTitle;

+ (nullable UIViewController *)viewControllerForPresentingAlert;

@end

NS_ASSUME_NONNULL_END
