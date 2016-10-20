//
//  UIAlertController+SAP.m
//  VIPorbit
//
//  Created by SAP on 8/17/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "UIAlertController+SAPExtensions.h"

#import "UIAlertAction+SAPExtensions.h"

static NSString * const kSAPErrorTitle = @"Error";

@implementation UIAlertController (SAPExtensions)

+ (void)presentWithTitle:(NSString *)title message:(NSString *)message {
    [self presentWithTitle:title message:message cancelButtonTitle:[UIAlertAction OKAction].title];
}

+ (void)presentWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:nil]];
    
    [[self viewControllerForPresentingAlert] presentViewController:alert animated:YES completion:nil];
}

+ (void)presentWithTitle:(NSString *)title message:(NSString *)message primaryActionTitle:(NSString *)primaryActionTitle handler:(void (^)(UIAlertAction * _Nonnull))handler cancelButtonTitle:(NSString *)cancelButtonTitle {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:primaryActionTitle style:UIAlertActionStyleDefault handler:handler]];
    [alert addAction:[UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:nil]];
    
    [[self viewControllerForPresentingAlert] presentViewController:alert animated:YES completion:nil];
}

+ (void)presentWithTitle:(NSString *)title message:(NSString *)message primaryActionTitle:(nullable NSString *)primaryActionTitle handler:(void (^ _Nullable)(UIAlertAction * _Nonnull))handler secondaryActionTitle:(nullable NSString *)secondaryActionTitle secondaryHandler:(void (^ _Nullable)(UIAlertAction * _Nonnull))secondaryHandler cancelButtonTitle:(nullable NSString *)cancelButtonTitle {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:primaryActionTitle style:UIAlertActionStyleDefault handler:handler]];
    [alert addAction:[UIAlertAction actionWithTitle:secondaryActionTitle style:UIAlertActionStyleDefault handler:secondaryHandler]];
    [alert addAction:[UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:nil]];
    
    [[self viewControllerForPresentingAlert] presentViewController:alert animated:YES completion:nil];
}

+ (nullable UIViewController *)viewControllerForPresentingAlert {
    
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (viewController != nil && viewController.presentedViewController != nil) {
        viewController = viewController.presentedViewController;
    }
    
    return viewController;
}

+ (void)presentWithError:(NSError *)error {
    [self presentWithTitle:kSAPErrorTitle message:[error localizedDescription]];
}

@end
