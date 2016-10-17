//
//  SAPCollectionChangeModel+SAPArrayModel.h
//  IOSProject
//
//  Created by S A P on 2/18/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPCollectionChangeModel.h"

@interface SAPCollectionChangeModel (SAPArrayModel)

+ (instancetype)additionModelWithIndex:(NSUInteger)index;
+ (instancetype)insertionModelWithIndex:(NSUInteger)index;
+ (instancetype)removalModelWithIndex:(NSUInteger)index;
+ (instancetype)replacementModelWithIndex:(NSUInteger)index;
+ (instancetype)updatingModelWithIndex:(NSUInteger)index;

+ (instancetype)movingModelFromIndex:(NSUInteger)fromIndex
                             toIndex:(NSUInteger)toIndex;
+ (instancetype)exchangingModelAtIndex:(NSUInteger)index
                      withModelAtIndex:(NSUInteger)toIndex;

@end
