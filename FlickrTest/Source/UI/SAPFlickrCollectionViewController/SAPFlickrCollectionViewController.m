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
#import "NSString+SAPExtensions.h"

#import "SAPViewControllerMacro.h"

static CGFloat const kSAPAnnotationPadding  = 0.0;
static CGFloat const kSAPTitleFontSize      = 12.0;
static CGFloat const kSAPCommentFontSize    = 11.0;
static CGFloat const kSAPAuthorFontSize     = 12.0;
static CGFloat const kSAPTextLeftInset      = 4;

SAPViewControllerBaseViewProperty(SAPFlickrCollectionViewController, SAPFlickrImagesView, mainView);

@interface SAPFlickrCollectionViewController () <
UICollectionViewDelegate,
UICollectionViewDataSource,
SAPFlickrLayoutDelegate>

@property (nonatomic, readonly) SAPArrayModel       *images;
@property (nonatomic, readonly) UICollectionView    *collectionView;

- (void)presentFullScreenImage:(UIImage *)image;

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
    
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 3, 40, 3);
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
#pragma mark UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SAPFlickrImage *imageModel = self.images[indexPath.row];
    [self presentFullScreenImage:imageModel.image];
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
    width = width - kSAPTextLeftInset;
    SAPFlickrImage *flickrImage = self.images[indexPath.row];
    UIFont *titleFont = [UIFont systemFontOfSize:kSAPTitleFontSize];
    UIFont *commentFont = [UIFont systemFontOfSize:kSAPCommentFontSize];
    UIFont *authorFont = [UIFont systemFontOfSize:kSAPAuthorFontSize];
    
    CGFloat titleHeight = [flickrImage.title heigthWithFont:titleFont width:width];
    CGFloat commentHeight = [flickrImage.comment heigthWithFont:commentFont width:width];
    CGFloat authorHeight = [flickrImage.author heigthWithFont:authorFont width:width];
    
    CGFloat height = kSAPAnnotationPadding + titleHeight + commentHeight + authorHeight + kSAPAnnotationPadding;
    
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

#pragma mark -
#pragma mark Interface Handling

- (void)handleSingleTap {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark Private

- (void)presentFullScreenImage:(UIImage *)image {
    UIViewController * imageViewController = [[UIViewController alloc] init];
    UIBlurEffect * blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurView.frame = self.view.bounds;
    
    imageViewController.view.frame = self.view.bounds;
    imageViewController.view.backgroundColor = [UIColor clearColor];
    [imageViewController.view insertSubview:blurView atIndex:0];
    imageViewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    [self presentViewController:imageViewController animated:YES completion:nil];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:imageViewController.view.bounds];
    imgView.image = image;
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    [imageViewController.view addSubview:imgView];
    
    UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(handleSingleTap)];
    [imageViewController.view addGestureRecognizer:singleFingerTap];
}

@end
