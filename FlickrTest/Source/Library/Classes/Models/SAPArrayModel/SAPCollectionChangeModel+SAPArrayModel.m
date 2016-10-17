//
//  SAPCollectionChangeModel+SAPArrayModel.m
//  IOSProject
//
//  Created by S A P on 2/18/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPCollectionChangeModel+SAPArrayModel.h"

#import "SAPCollectionChangeIndexModel.h"
#import "SAPCollectionChangeDoubleIndexModel.h"

@implementation SAPCollectionChangeModel (SAPArrayModel)

//SAPCollectionChangeIndexModel

+ (instancetype)additionModelWithIndex:(NSUInteger)index {
    return [SAPCollectionChangeIndexModel modelWithChangeType:kSAPChangeTypeObjectAdded index:index];
}

+ (instancetype)insertionModelWithIndex:(NSUInteger)index {
    return [SAPCollectionChangeIndexModel modelWithChangeType:kSAPChangeTypeObjectInserted index:index];
}

+ (instancetype)removalModelWithIndex:(NSUInteger)index {
    return [SAPCollectionChangeIndexModel modelWithChangeType:kSAPChangeTypeObjectRemoved index:index];
}

+ (instancetype)replacementModelWithIndex:(NSUInteger)index {
    return [SAPCollectionChangeIndexModel modelWithChangeType:kSAPChangeTypeObjectReplaced index:index];
}

+ (instancetype)updatingModelWithIndex:(NSUInteger)index {
    return  [SAPCollectionChangeIndexModel modelWithChangeType:kSAPChangeTypeObjectUpdated index:index];
}

//SAPCollectionChangeDoubleIndexModel

+ (instancetype)movingModelFromIndex:(NSUInteger)fromIndex
                             toIndex:(NSUInteger)toIndex {
    return [SAPCollectionChangeDoubleIndexModel modelWithChangeType:kSAPChangeTypeObjectMoved
                                                         index:fromIndex
                                                       toIndex:toIndex];
}

+ (instancetype)exchangingModelAtIndex:(NSUInteger)index
                      withModelAtIndex:(NSUInteger)toIndex {
    return [SAPCollectionChangeDoubleIndexModel modelWithChangeType:kSAPChangeTypeObjectExchanged
                                                         index:index
                                                       toIndex:toIndex];
}


@end
