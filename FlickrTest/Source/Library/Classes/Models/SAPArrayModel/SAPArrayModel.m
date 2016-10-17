//
//  SAPArrayModel.m
//  IOSProject
//
//  Created by S A P on 2/12/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPArrayModel.h"

#import "SAPCollectionChangeIndexModel.h"
#import "SAPCollectionChangeDoubleIndexModel.h"

#import "SAPCollectionChangeModel+SAPArrayModel.h"

#import "SAPCollectionObserver.h"

@interface SAPArrayModel ()
@property (nonatomic, strong) NSMutableArray *mutableObjects;

- (void)notifyWithChangeModel:(SAPCollectionChangeModel *)changeModel;

@end

@implementation SAPArrayModel

@dynamic count;
@dynamic objects;

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
        self.mutableObjects = [NSMutableArray new];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)objects {
    @synchronized(self) {
        return [self.mutableObjects copy];
    }
}

- (NSUInteger)count {
    @synchronized(self) {
        return self.mutableObjects.count;
    }
}

#pragma mark -
#pragma mark Public

- (id)objectAtIndex:(NSUInteger) index {
    @synchronized(self) {
        return [self.mutableObjects objectAtIndex:index];
    }
}

- (id)objectAtIndexedSubscript:(NSUInteger) index {
    return [self objectAtIndex:index];
}

- (void)addObject:(id)anObject {
    @synchronized(self) {
        [self.mutableObjects addObject:anObject];
        
        [self notifyWithChangeModel:[SAPCollectionChangeModel additionModelWithIndex:self.count - 1]];
    }
}

- (void)insertObject:(id)anObject atIndex:(NSUInteger)index {
    @synchronized(self) {
        [self.mutableObjects insertObject:anObject atIndex:index];
        
        [self notifyWithChangeModel:[SAPCollectionChangeModel insertionModelWithIndex:index]];
    }
}

- (void)removeLastObject {
    @synchronized(self) {
        [self.mutableObjects removeLastObject];
        
        [self notifyWithChangeModel:[SAPCollectionChangeModel removalModelWithIndex:self.count - 1]];
    }
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    @synchronized(self) {
        [self.mutableObjects removeObjectAtIndex:index];

        [self notifyWithChangeModel:[SAPCollectionChangeModel removalModelWithIndex:index]];
    }
}

- (void)updateObjectAtIndex:(NSUInteger)index {
    @synchronized(self) {
        [self notifyWithChangeModel:[SAPCollectionChangeModel updatingModelWithIndex:index]];
    }
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    @synchronized(self) {
        [self.mutableObjects replaceObjectAtIndex:index withObject:anObject];
        
        [self notifyWithChangeModel:[SAPCollectionChangeModel replacementModelWithIndex:index]];
    }
}

- (void)exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2 {
    @synchronized(self) {
        [self.mutableObjects exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
        
        [self notifyWithChangeModel:[SAPCollectionChangeModel exchangingModelAtIndex:idx1 withModelAtIndex:idx2]];
    }
}

- (void)moveObjectFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    @synchronized(self) {
        NSMutableArray *mutableObjects = self.mutableObjects;
        id objectFromIndex = mutableObjects[fromIndex];
        [mutableObjects removeObjectAtIndex:fromIndex];
        [mutableObjects insertObject:objectFromIndex atIndex:toIndex];
    }
}

#pragma mark -
#pragma mark Private

- (void)notifyWithChangeModel:(SAPCollectionChangeModel *)changeModel; {
    [self notifyObserversWithSelector:@selector(collection:didChangeWithModel:)
                           withObject:changeModel];
}

@end
