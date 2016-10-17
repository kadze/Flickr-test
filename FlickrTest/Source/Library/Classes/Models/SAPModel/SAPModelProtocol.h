//
//  SAPModelProtocol.h
//  IOSProject
//
//  Created by Andrey on 4/25/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SAPObservableObjectProtocol.h"

@protocol SAPModelProtocol <SAPObservableObjectProtocol>
@optional
- (void)load;
- (void)performSynchronousBlock:(void(^)(void))block;
- (void)performBackgroundLoading;

@end
