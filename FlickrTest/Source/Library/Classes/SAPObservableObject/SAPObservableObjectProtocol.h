//
//  SAPObservableObjectProtocol.h
//  IOSProject
//
//  Created by Andrey on 4/25/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SAPObservableObjectProtocol <NSObject>
@optional
@property (nonatomic, assign)   NSUInteger  state;
@property (nonatomic, readonly) NSArray     *observers;
@property (nonatomic, strong)   id          target;

- (instancetype)initWithTarget:(id)target;

- (void)addObserverObject:(id)observer;
- (void)removeObserver:(id)observer;
- (void)removeObserversFromArray:(NSArray *)array;
- (void)addObserversFromArray:(NSArray *)array;

- (void)setState:(NSUInteger)state withObject:(id)object;

- (void)notifyObserversWithSelector:(SEL)selector;
- (void)notifyObserversWithSelector:(SEL)selector withObject:(id)object;

- (void)performBlockWithNotification:(void(^)(void))block;
- (void)performBlockWithoutNotification:(void(^)(void))block;

- (SEL)selectorForState:(NSUInteger)state;

@end
