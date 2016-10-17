//
//  SAPManagedObject.m
//  IOSProject
//
//  Created by Andrey on 4/19/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPManagedObject.h"

#import "SAPModel.h"

@interface SAPManagedObject ()
@property (nonatomic, strong) SAPModel *model;

@end

@implementation SAPManagedObject
@synthesize model = _model;

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context {
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    SAPModel *model = [[SAPModel alloc] initWithTarget:self];
    model.state = kSAPModelStateUnloaded;
    self.model = model;
    
    return self;
}

#pragma mark -
#pragma mark Message Forwarding

- (id)forwardingTargetForSelector:(SEL)aSelector {
    SAPModel *model = self.model;
    if ([model respondsToSelector:aSelector]) {
        return model;
    }
    
    return [super forwardingTargetForSelector:aSelector];
}

@end
