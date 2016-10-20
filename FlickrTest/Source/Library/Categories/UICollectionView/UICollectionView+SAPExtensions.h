//
//  UICollectionView+SAPExtensions.h
//  IOSProject
//
//  Created by Andrey on 8/15/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <UIKit/UICollectionView.h>

@interface UICollectionView (SAPExtensions)

- (id)cellWithClass:(Class)aClass forIndexPath:(NSIndexPath *)indexPath;

@end
