//
//  SAPCollectionChangeIndexModel.h
//  IOSProject
//
//  Created by S A P on 2/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPCollectionChangeModel.h"

typedef NS_ENUM (NSUInteger, SAPArrayIndexChangeType) {
    kSAPChangeTypeObjectAdded,
    kSAPChangeTypeObjectInserted,
    kSAPChangeTypeObjectRemoved,
    kSAPChangeTypeObjectReplaced,
    kSAPChangeTypeObjectUpdated
};

@interface SAPCollectionChangeIndexModel : SAPCollectionChangeModel
@property (nonatomic, readonly) NSUInteger index;

+ (id)modelWithChangeType:(NSUInteger)changeType
                    index:(NSUInteger)index;

@end
