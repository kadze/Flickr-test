//
//  UICollectionView+SAPExtensions.m
//  IOSProject
//
//  Created by Andrey on 8/15/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "UICollectionView+SAPExtensions.h"

#import "UINib+SAPExtensions.h"

@implementation UICollectionView (SAPExtensions)

- (id)cellWithClass:(Class)aClass forIndexPath:(NSIndexPath *)indexPath {
    id cell = [self dequeueReusableCellWithReuseIdentifier:NSStringFromClass(aClass) forIndexPath:indexPath];
    if (!cell) {
        cell = [UINib objectWithClass:aClass];
    }
    
    return cell;
}

@end
