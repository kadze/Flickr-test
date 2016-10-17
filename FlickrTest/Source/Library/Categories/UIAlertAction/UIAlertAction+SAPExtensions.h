//
//  UIAlertAction+SAPExtensions.h
//  VIPorbit
//
//  Created by Andrey on 7/28/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIAlertAction (SAPExtensions)

+ (instancetype)defaultActionWithTitle:(NSString *)title
                        handler:(void (^)(UIAlertAction * _Nonnull))handler;

+ (instancetype)OKAction;
+ (instancetype)cancelAction;
+ (instancetype)cancelActionWithTitle:(nullable NSString *)title
                              handler:(nullable void (^)(UIAlertAction *))handler;

+ (instancetype)destructiveActionWithTitle:(NSString *)title
                                   handler:(void (^)(UIAlertAction * _Nonnull))handler;

@end

NS_ASSUME_NONNULL_END
