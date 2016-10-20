//
//  SAPFlickrLayout.m
//  FlickrTest
//
//  Created by ASH on 10/17/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPFlickrLayout.h"

#import "SAPFlickrLayoutAttributes.h"

static NSUInteger const kSAPColumnsCount    = 2;
static CGFloat const kSAPCellPadding        = 8.0;

@interface SAPFlickrLayout()
@property (nonatomic, assign)           CGFloat contentHeight;
@property (nonatomic, assign, readonly) CGFloat contentWidth;
@property (nonatomic, strong) NSMutableArray<SAPFlickrLayoutAttributes *> *cache;

@end

@implementation SAPFlickrLayout

@dynamic contentWidth;

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.cache = [NSMutableArray<SAPFlickrLayoutAttributes *> new];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (CGFloat)contentWidth {
    UICollectionView *collectionView = self.collectionView;
    UIEdgeInsets inset = collectionView.contentInset;
    
    return CGRectGetWidth(collectionView.bounds) - (inset.left + inset.right);
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(self.contentWidth, self.contentHeight);
}

- (Class)layoutAttributesClass {
    return [SAPFlickrLayoutAttributes class];
}

#pragma mark -
#pragma mark Public

- (void)prepareLayout {
    if (self.cache.count == 0) {
        CGFloat columnWidth = self.contentWidth / kSAPColumnsCount;
        CGFloat xOffset[kSAPColumnsCount];
        for (NSUInteger columnIndex = 0; columnIndex < kSAPColumnsCount; columnIndex++) {
            xOffset[columnIndex] = columnIndex * columnWidth;
        }
        
        NSUInteger column = 0;
        CGFloat yOffset[kSAPColumnsCount];
        NSUInteger sectionIndex = 0;
        UICollectionView *collectionView = self.collectionView;
        
        for (NSUInteger item = 0; item < [collectionView numberOfItemsInSection:sectionIndex]; item++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:item inSection:sectionIndex];
            CGFloat width = columnWidth - kSAPCellPadding * 2;
            CGFloat imageHeight = [self.delegate collectionView:collectionView
                                      heightForImageAtIndexPath:indexPath
                                                      withWidth:width];
            
            CGFloat annotationHeight = [self.delegate collectionView:collectionView
                                      heightForAnnotationAtIndexPath:indexPath
                                                           withWidth:width];
            
            CGFloat height = kSAPCellPadding + imageHeight + annotationHeight + kSAPCellPadding;
            CGRect frame = CGRectMake(xOffset[column], yOffset[column], columnWidth, height);
            CGRect insetFrame = CGRectInset(frame, kSAPCellPadding, kSAPCellPadding);
            
            SAPFlickrLayoutAttributes *attributes = [SAPFlickrLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            attributes.imageHeight = imageHeight;
            attributes.frame = insetFrame;
            [self.cache addObject:attributes];
            
            self.contentHeight = MAX(self.contentHeight, CGRectGetMaxY(frame));
            yOffset[column] = yOffset[column] + height;
            column = column >= (kSAPColumnsCount - 1) ? 0 : ++column;
        }
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray<UICollectionViewLayoutAttributes *> *layoutAttributes = [NSMutableArray<UICollectionViewLayoutAttributes *> new];
    for (UICollectionViewLayoutAttributes *attributesElement in self.cache) {
        if (CGRectIntersectsRect(attributesElement.frame, rect)) {
            [layoutAttributes addObject:attributesElement];
        }
    }
    
    return layoutAttributes;
}

@end
