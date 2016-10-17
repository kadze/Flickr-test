//
//  SAPObjectCache.h
//  IOSProject
//
//  Created by SAP on 3/12/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SAPObjectCache : NSObject
@property (nonatomic, copy, readonly) NSArray *allKeys;

- (id)objectForKey:(id)key;
- (void)setObject:(id)object forKey:(id)key;

- (id)objectForKeyedSubscript:(id)key;
- (void)setObject:(id)object forKeyedSubscript:(id)key;

@end
