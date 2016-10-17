//
//  SAPModelKeeper.h
//  IOSProject
//
//  Created by SAP on 3/27/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SAPModel;

@protocol SAPModelView <NSObject>
@property (nonatomic, strong) id model;

- (void)fillWithModel:(id)model;

@end
