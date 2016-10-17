//
//  SAPLoadWaitView.h
//  IOSProject
//
//  Created by S A P on 2/24/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SAPLoadingView.h"

@interface SAPActivityIndicator : UIView <SAPLoadingView>
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;

+ (instancetype)indicatorWithSuperview:(UIView *)superview;

@end
