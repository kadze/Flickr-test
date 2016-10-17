//
//  SAPImageView.h
//  IOSProject
//
//  Created by S A P on 3/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPView.h"

#import "SAPModelObserver.h"

#import "SAPImageModel.h"

@interface SAPImageView : SAPView <SAPModelObserver>
@property (nonatomic, strong) SAPImageModel *imageModel;

@end
