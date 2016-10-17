//
//  SAPImageView.m
//  IOSProject
//
//  Created by S A P on 3/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//
#import <UIKit/UIImageView.h>

#import "SAPImageView.h"

#import "SAPDispatch.h"

@interface SAPImageView ()
@property (nonatomic, strong) UIImageView *imageView;

- (void)fillWithModel:(SAPImageModel *)imageModel;
- (void)prepareSubviews;

@end

@implementation SAPImageView

#pragma mark -
#pragma mark NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    [self prepareSubviews];
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self prepareSubviews];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setImageModel:(SAPImageModel *)imageModel {
    if (_imageModel != imageModel) {
        [self fillWithModel:nil];
        [_imageModel removeObserver:self];
        _imageModel = imageModel;
        [_imageModel addObserverObject:self];
        [_imageModel load];
    }
}

#pragma mark -
#pragma mark SAPModelObserver

- (void)modelWillLoad:(id)model {
    SAPDispatchAsyncOnMainQueue(^{
        self.loadingViewVisible = YES;
    });
}

- (void)modelDidFinishLoading:(id)model {
    SAPDispatchAsyncOnMainQueue(^{
        [self fillWithModel:model];
        self.loadingViewVisible = NO;
    });
}

- (void)modelDidFailLoading:(id)model {
    self.loadingViewVisible = NO;
}

#pragma mark -
#pragma mark Private

- (void)fillWithModel:(SAPImageModel *)model {
    self.imageView.image = model.image;
}

- (void)prepareSubviews {
    UIImageView *subview = [[UIImageView alloc] initWithFrame:self.bounds];
    self.imageView = subview;
    [self addSubview:subview];
    subview.autoresizingMask = UIViewAutoresizingFlexibleWidth
                                      | UIViewAutoresizingFlexibleHeight;
}

@end
