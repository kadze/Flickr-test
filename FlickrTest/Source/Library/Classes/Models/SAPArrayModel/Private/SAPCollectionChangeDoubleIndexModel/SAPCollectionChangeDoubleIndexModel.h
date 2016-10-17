//
//  SAPCollectionChangeDoubleIndexModel.h
//  IOSProject
//
//  Created by S A P on 2/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPCollectionChangeIndexModel.h"

typedef NS_ENUM(NSUInteger, SAPArrayDoubleIndexChangeType) {
    kSAPChangeTypeObjectExchanged,
    kSAPChangeTypeObjectMoved
};

@interface SAPCollectionChangeDoubleIndexModel : SAPCollectionChangeIndexModel
@property (nonatomic, readonly) NSUInteger toIndex;

+ (id)modelWithChangeType:(NSUInteger)changeType
                    index:(NSUInteger)fromIndex
                  toIndex:(NSUInteger)toIndex;

@end
