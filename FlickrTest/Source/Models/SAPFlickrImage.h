//
//  SAPFlickrImage.h
//  FlickrTest
//
//  Created by ASH on 10/18/16.
//  Copyright © 2016 SAP. All rights reserved.
//
#import <UIKit/UIImage.h>

#import "SAPModel.h"

@interface SAPFlickrImage : SAPModel
@property (nonatomic, strong) UIImage   *image;
@property (nonatomic, copy) NSString    *caption;
@property (nonatomic, copy) NSString    *comment;

- (CGFloat)heigthForCommentWithFont:(UIFont *)font width:(CGFloat)width;

@end
