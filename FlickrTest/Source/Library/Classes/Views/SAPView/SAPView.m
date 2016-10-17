//
//  SAPView.m
//  IOSProject
//
//  Created by S A P on 2/26/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPView.h"

#import "SAPActivityIndicator.h"

#import "UINib+SAPExtensions.h"

@implementation SAPView

#pragma mark -
#pragma mark Accessors

- (void)setLoadingView:(UIView<SAPLoadingView> *)loadingView {
    if (_loadingView != loadingView) {
        [_loadingView removeFromSuperview];
        _loadingView = loadingView;
        [self addSubview:loadingView];
    }
}

- (void)setLoadingViewVisible:(BOOL)loadingViewVisible {
    [self setLoadingViewVisible:loadingViewVisible animated:YES];
}

- (void)setLoadingViewVisible:(BOOL)loadingViewVisible
                     animated:(BOOL)animated
{
    [self setLoadingViewVisible:loadingViewVisible animated:animated completion:nil];
}

- (void)setLoadingViewVisible:(BOOL)loadingViewVisible
                     animated:(BOOL)animated
                   completion:(void(^)(void))completion
{
    if (_loadingViewVisible != loadingViewVisible) {
        if (loadingViewVisible && !self.loadingView) {
            self.loadingView = [self createLoadingView];
        }
        
        _loadingViewVisible = loadingViewVisible;
        
        [self bringSubviewToFront:self.loadingView];
        [self.loadingView setVisible:loadingViewVisible animated:animated completion:completion];        
    }
}

#pragma mark -
#pragma mark Public

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.loadingView.frame = self.bounds;
}

#pragma mark -
#pragma mark Private

- (UIView<SAPLoadingView> *)createLoadingView {
    return [UINib objectWithClass:[SAPActivityIndicator class]];
}

@end
