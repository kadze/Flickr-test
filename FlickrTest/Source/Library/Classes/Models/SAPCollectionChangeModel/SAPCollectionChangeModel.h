//
//  SAPCollectionChangeModel.h
//  IOSProject
//
//  Created by S A P on 2/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SAPCollectionChangeModel : NSObject
@property (nonatomic, readonly) NSUInteger changeType;

+ (id)modelWithChangeType:(NSUInteger)changeType;

- (instancetype)initWithChangeType:(NSUInteger)changeType;

@end
