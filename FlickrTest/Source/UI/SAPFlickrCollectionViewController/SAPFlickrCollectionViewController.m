//
//  SAPFlickrCollectionViewController.m
//  FlickrTest
//
//  Created by ASH on 10/17/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

#import "SAPFlickrCollectionViewController.h"

#import "SAPFlickrImagesView.h"
#import "SAPFlickrImageCell.h"
#import "SAPFlickrLayout.h"
#import "SAPArrayModel.h"
#import "SAPFlickrImage.h"
#import "SAPFlickrContext.h"

#import "UINib+SAPExtensions.h"

#import "SAPViewControllerMacro.h"

static CGFloat const kSAPAnnotationPadding      = 4.0;
static CGFloat const kSAPAnnotationHeaderHeight = 20.0;

SAPViewControllerBaseViewProperty(SAPFlickrCollectionViewController, SAPFlickrImagesView, mainView);

@interface SAPFlickrCollectionViewController () <
UICollectionViewDelegate,
UICollectionViewDataSource,
SAPFlickrLayoutDelegate>

@property (nonatomic, readonly) SAPArrayModel       *images;
@property (nonatomic, readonly) UICollectionView    *collectionView;

@end

@implementation SAPFlickrCollectionViewController

@dynamic collectionView;

#pragma mark -
#pragma mark Accessors

- (UICollectionView *)collectionView {
    return self.mainView.collectionView;
}

- (SAPArrayModel *)images {
    return (SAPArrayModel *)(self.model);
}

- (SAPContext *)modelContext {
    return [SAPFlickrContext contextWithModel:self.model];
}

#pragma mark-
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewLayout *collectionViewLayout = self.collectionView.collectionViewLayout;
    if ([collectionViewLayout isKindOfClass:[SAPFlickrLayout class]]) {
        ((SAPFlickrLayout *)collectionViewLayout).delegate = self;
    }
    
    Class cellClass = [SAPFlickrImageCell class];
    UINib *nib = [UINib nibWithClass:cellClass];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:NSStringFromClass(cellClass)];
}

#pragma mark -
#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    SAPArrayModel *items = self.model;
    
    return items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SAPFlickrImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SAPFlickrImageCell class]) forIndexPath:indexPath];
    cell.model = self.images[indexPath.row];
    
    return cell;
}

#pragma mark -
#pragma mark SAPFlickrLayoutDelegate

- (CGFloat)     collectionView:(UICollectionView *)collectionView
     heightForImageAtIndexPath:(NSIndexPath *)indexPath
                     withWidth:(CGFloat)width
{
    SAPFlickrImage *flickrImage = self.images[indexPath.row];
    CGRect boundingRect = CGRectMake(0, 0, width, CGFLOAT_MAX);
    CGRect rect = AVMakeRectWithAspectRatioInsideRect(flickrImage.image.size, boundingRect);
    
    return rect.size.height;
}

- (CGFloat)     collectionView:(UICollectionView *)collectionView
heightForAnnotationAtIndexPath:(NSIndexPath *)indexPath
                     withWidth:(CGFloat)width
{
    SAPFlickrImage *flickrImage = self.images[indexPath.row];
    UIFont *font = [UIFont systemFontOfSize:12.0];
    CGFloat commentHeight = [flickrImage heigthForCommentWithFont:font width:width];
    CGFloat height = kSAPAnnotationPadding + kSAPAnnotationHeaderHeight + commentHeight + kSAPAnnotationPadding;
    
    return height;
}

#pragma mark -
#pragma mark Public

- (void)updateViewControllerWithModel:(id)model {
    [self.collectionView reloadData];
}

- (void)finishModelSetting {
    self.context = self.modelContext;
}

@end
