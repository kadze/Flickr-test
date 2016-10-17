//
//  SAPView.h
//  IOSProject
//
//  Created by S A P on 2/26/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <UIKit/UIView.h>

#import "SAPLoadingView.h"

@interface SAPView : UIView
@property (nonatomic, readonly) UIView <SAPLoadingView> *loadingView;

@property (nonatomic, assign) BOOL loadingViewVisible;

- (void)setLoadingViewVisible:(BOOL)loadingViewVisible
                     animated:(BOOL)animated;
- (void)setLoadingViewVisible:(BOOL)loadingViewVisible
                     animated:(BOOL)animated
                   completion:(void(^)(void))completion;

@end
