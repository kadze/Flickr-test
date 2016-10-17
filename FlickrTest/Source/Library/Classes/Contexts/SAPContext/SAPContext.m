//
//  SAPContext.m
//  IOSProject
//
//  Created by SAP on 3/16/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPContext.h"

#import "SAPModel.h"

@implementation SAPContext

#pragma mark -
#pragma mark Initializations and deallocations

- (instancetype)initWithModel:(id)model {
    self = [super init];
    self.model = model;
    
    return self;
}

#pragma mark -
#pragma mark Class Methods

+ (instancetype)contextWithModel:(id)model {
    return [[self alloc] initWithModel:model];
}

#pragma mark -
#pragma mark Public

- (void)execute {
    SAPModel *model = self.model;
    @synchronized (model) {
        NSUInteger state = model.state;
        if (![self shouldLoadWithState:state]) {
            [model notifyObserversWithSelector:[model selectorForState:state]];
            
            return;
        }
        
        model.state = kSAPModelStateWillLoad;
    }
    
    [self stateUnsafeLoad];
}

- (BOOL)shouldLoadWithState:(NSInteger)state {
    return state == kSAPModelStateUnloaded;
}

- (void)cancel {
    
}

- (void)load {
    
}

- (void)stateUnsafeLoad {
    
}

@end
