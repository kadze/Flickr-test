//
//  SAPFlickrImage.h
//  FlickrTest
//
//  Created by ASH on 10/18/16.
//  Copyright © 2016 SAP. All rights reserved.
//
#import <UIKit/UIImage.h>

#import "SAPModel.h"

@class UIFont;

@interface SAPFlickrImage : SAPModel
@property (nonatomic, strong) UIImage   *image;
@property (nonatomic, copy) NSString    *title;
@property (nonatomic, copy) NSString    *comment;
@property (nonatomic, copy) NSString    *ID;
@property (nonatomic, copy) NSString    *urlString;

- (CGFloat)heigthForCommentWithFont:(UIFont *)font width:(CGFloat)width;

@end
