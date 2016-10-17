//
//  SAPBundleImageModel.m
//  ToDoList
//
//  Created by Andrey on 5/16/16.
//  Copyright © 2016 Andrey. All rights reserved.
//

#import "SAPBundleImageModel.h"

@implementation SAPBundleImageModel

#pragma mark -
#pragma mark SAPCacheableModel

- (NSString *)path {
    NSURL *url = self.url;
    NSString *resource = url.absoluteString;
    return [[NSBundle mainBundle] pathForResource:resource ofType:nil];
}

@end
