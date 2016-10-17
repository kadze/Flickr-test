//
//  SAPLoadingView.h
//  IOSProject
//
//  Created by S A P on 2/26/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SAPLoadingView <NSObject>
@property (nonatomic, assign, getter=isViewVisible) BOOL visible;

- (void)setVisible:(BOOL)visible animated:(BOOL)animated;
- (void)setVisible:(BOOL)visible animated:(BOOL)animated completion:(void(^)(void))completion;

@end
