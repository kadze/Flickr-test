//
//  SAPReference.h
//  MacCourse
//
//  Created by S A P on 12/11/15.
//  Copyright © 2015 Yosemite Retail. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SAPReference : NSObject <NSCopying>
@property (nonatomic, strong) id target;

///override in subclass
- (instancetype)initWithTarget:(id)object;

@end
