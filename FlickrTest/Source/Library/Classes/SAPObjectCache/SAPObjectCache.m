//
//  SAPObjectCache.m
//  IOSProject
//
//  Created by SAP on 3/12/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPObjectCache.h"

@interface SAPObjectCache ()
@property (nonatomic, strong) NSMapTable *objects;

@end

@implementation SAPObjectCache

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    self.objects = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory
                                                      | NSPointerFunctionsObjectPointerPersonality
                                         valueOptions:NSPointerFunctionsWeakMemory];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)allKeys {
    @synchronized (self) {
        return self.objects.keyEnumerator.allObjects;
    }
}

#pragma mark -
#pragma mark Public

- (id)objectForKey:(id)key {
    @synchronized (self) {
        return [self.objects objectForKey:key];
    }
}

- (void)setObject:(id)object forKey:(id)key {
    @synchronized (self) {
        [self.objects setObject:object forKey:key];
    }
}

- (id)objectForKeyedSubscript:(id)key {
    return [self objectForKey:key];
}

- (void)setObject:(id)object forKeyedSubscript:(id)key {
    [self setObject:object forKey:key];
}

@end
