//
//  SAPFlickrImageCell.h
//  FlickrTest
//
//  Created by ASH on 10/17/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SAPModelView.h"

@interface SAPFlickrImageCell : UICollectionViewCell <SAPModelView>
@property (nonatomic, strong) IBOutlet UIView       *view;
@property (nonatomic, strong) IBOutlet UIImageView  *imageView;
@property (nonatomic, strong) IBOutlet UILabel      *captionLabel;
@property (nonatomic, strong) IBOutlet UILabel      *commentLabel;
@property (nonatomic, strong) IBOutlet UILabel      *authorLabel;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *imageHeightConstraint;

@end
