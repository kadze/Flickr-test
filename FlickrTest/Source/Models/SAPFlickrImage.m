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
   return [self heigthForString:self.comment withFont:font width:width];
}

- (CGFloat)heigthForAuthorWithFont:(UIFont *)font width:(CGFloat)width {
    return [self heigthForString:self.author withFont:font width:width];
}

#pragma mark -
#pragma mark Private

- (CGFloat)heigthForString:(NSString *)string withFont:(UIFont *)font width:(CGFloat)width {
    if (string == nil || string.length == 0) {
        return 0;
    }
    
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil];
    
    return ceil(rect.size.height);
}

@end
