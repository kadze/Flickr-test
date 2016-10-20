//
//  SAPFlickrImageCell.m
//  FlickrTest
//
//  Created by ASH on 10/17/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPFlickrImageCell.h"

#import "SAPFlickrImage.h"
#import "SAPFlickrLayoutAttributes.h"

static CGFloat const kSAPCornerRadius = 8.0;

@implementation SAPFlickrImageCell

@synthesize model = _model;

- (void)awakeFromNib {
    [super awakeFromNib];
    self.view.layer.cornerRadius = kSAPCornerRadius;
}

#pragma mark -
#pragma mark Accessors

- (void)setModel:(SAPFlickrImage *)model {
    if (_model != model) {
        _model = model;
        
        [self fillWithModel:model];
    }
}

#pragma mark -
#pragma mark SAPModelView

- (void)fillWithModel:(SAPFlickrImage *)model {
    self.imageView.image = model.image;
    self.captionLabel.text = model.title;
    self.commentLabel.text = model.comment;
}

#pragma mark -
#pragma mark Public

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    if ([layoutAttributes isKindOfClass:[SAPFlickrLayoutAttributes class]]) {
        self.imageHeightConstraint.constant = ((SAPFlickrLayoutAttributes *)layoutAttributes).imageHeight;
    }
}

@end
