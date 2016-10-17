//
//  NSURL+SAPJSONURL.m
//  IOSProject
//
//  Created by Andrey on 4/15/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "NSURL+SAPJSONURL.h"

@implementation NSURL (SAPJSONURL)

- (NSString *)JSONRepresentation {
    return [self absoluteString];
}

@end
