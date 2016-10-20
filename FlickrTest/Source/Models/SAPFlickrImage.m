//
//  SAPFlickrImage.m
//  FlickrTest
//
//  Created by ASH on 10/18/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <UIKit/NSStringDrawing.h>
#import <UIKit/UIFont.h>

#import "SAPFlickrImage.h"

@implementation SAPFlickrImage

#pragma mark -
#pragma mark Public

- (CGFloat)heigthForCommentWithFont:(UIFont *)font width:(CGFloat)width {
    CGRect rect = [self.comment boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil];
    
    return ceil(rect.size.height);
}

@end
