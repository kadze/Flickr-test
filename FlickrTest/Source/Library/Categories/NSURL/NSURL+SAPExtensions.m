//
//  NSURL+SAPExtensions.m
//  IOSProject
//
//  Created by S A P on 3/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "NSURL+SAPExtensions.h"

#import "NSString+SAPExtensions.h"

#import "SAPDispatchOnceMacro.h"

static NSString * const kSAPQuestionMark = @"?";
static NSString * const kSAPQuestionMarkSubstitute = @"SAPQuestionMark";
static NSString * const kSAPSlash = @"/";
static NSString * const kSAPSlashSubstitute = @"SAPSlash";

@implementation NSURL (SAPExtensions)

#pragma mark -
#pragma Public

- (NSString *)fileSystemStringRepresentation {
    NSString *result = [self absoluteString];
    NSDictionary *substitutions = [self fileSystemSubstitutionDictionary];
    
    return [result stringByReplacingOccurrencesOfKeysWithValuesInDictionary:substitutions];
}

#pragma mark -
#pragma Private

- (NSDictionary *)fileSystemSubstitutionDictionary {
    static NSDictionary *result = nil;
    SAPDispatchOnce((^{
        result = @{ kSAPQuestionMark : kSAPQuestionMarkSubstitute,
                    kSAPSlash : kSAPSlashSubstitute};
    }));
    
    return result;
}

@end
