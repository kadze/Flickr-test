//
//  SAPFlickrLayout.h
//  FlickrTest
//
//  Created by ASH on 10/17/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SAPFlickrLayoutDelegate <NSObject>

- (CGFloat)collectionView:(UICollectionView *)collectionView
  heightForImageAtIndexPath:(NSIndexPath *)indexPath
                withWidth:(CGFloat)width;

- (CGFloat)     collectionView:(UICollectionView *)collectionView
heightForAnnotationAtIndexPath:(NSIndexPath *)indexPath
                withWidth:(CGFloat)width;

@end

@interface SAPFlickrLayout : UICollectionViewLayout
@property (nonatomic, weak) id<SAPFlickrLayoutDelegate> delegate;

@end
