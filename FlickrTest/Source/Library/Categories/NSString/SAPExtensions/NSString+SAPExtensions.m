//
//  SAPStringAdditions.m
//  MacCourse
//
//  Created by S A P on 11/24/15.
//  Copyright © 2015 Yosemite Retail. All rights reserved.
//
#import <UIKit/NSStringDrawing.h>

#import "NSString+SAPExtensions.h"

static const unichar kSAPFirstLowerCaseLetter = 'a';
static const unichar kSAPLastLowerCaseLetter = 'z';
static const unichar kSAPFirstCapitalLetter = 'A';
static const unichar kSAPLastCapitalLetter = 'Z';
static const unichar kSAPFirstNumberSign = '0';
static const unichar kSAPLastNumberSign = '9';

@implementation NSString (SAPStringExtensions)

#pragma mark -
#pragma mark Class Methods

//alphabets
+ (instancetype)alphanumericAlphabet {
    NSMutableString *result = [NSMutableString stringWithString:[self numericAlphabet]];
    [result appendString:[self letterAlphabet]];
    
    return [self stringWithString:result];
}

+ (instancetype)numericAlphabet {
    return [self alphabetWithUnicodeRange:NSMakeRange(kSAPFirstNumberSign,
                                                      kSAPLastNumberSign - kSAPFirstNumberSign)];
}

+ (instancetype)letterAlphabet {
    NSMutableString *result = [NSMutableString stringWithString:[self lowerCaseLetterAlphabet]];
    [result appendString:[self capitalizedCaseLetterAlphabet]];
    
    return [self stringWithString:result];
}

+ (instancetype)lowerCaseLetterAlphabet {
    return [self alphabetWithUnicodeRange:NSMakeRange(kSAPFirstLowerCaseLetter,
                                                      kSAPLastLowerCaseLetter - kSAPFirstLowerCaseLetter)];
}

+ (instancetype)capitalizedCaseLetterAlphabet {
    return [self alphabetWithUnicodeRange:NSMakeRange(kSAPFirstCapitalLetter,
                                                      kSAPLastCapitalLetter - kSAPFirstCapitalLetter)];
}

+ (instancetype)alphabetWithUnicodeRange:(NSRange)range {
    NSMutableString *result = [NSMutableString string];
    for (unichar symbol = range.location; symbol <= NSMaxRange(range); symbol++) {
        [result appendFormat:@"%c", symbol];
    }
    
    return [self stringWithString:result];
}

//random strings
+ (instancetype)randomStringWithAlphabetString:(NSString *)alphabet length:(NSUInteger)length {
    int alphabetLength = (int)alphabet.length;
    unichar unichars[length];
    for (uint index = 0; index < length; index++) {
        unichars[index] = [alphabet characterAtIndex:arc4random_uniform(alphabetLength)];
    }
    
    return [self stringWithCharacters:unichars length:length];
}

#pragma mark -
#pragma mark Public Methods

- (instancetype)randomStringFromSelfOfLength:(NSUInteger)length {
    return [[self class] randomStringWithAlphabetString:self length:length];
}

- (instancetype)stringByReplacingOccurrencesOfKeysWithValuesInDictionary:(NSDictionary *)dictionary {
    NSMutableString *result = [NSMutableString stringWithString:self];
    for (id key in dictionary.allKeys) {
        [result replaceOccurrencesOfString:key
                                withString:dictionary[key]
                                   options:NSLiteralSearch
                                     range:NSMakeRange(0, self.length)];
    }
    
    return [result copy];
}

- (CGFloat)heigthWithFont:(UIFont *)font width:(CGFloat)width {
    if (self.length == 0) {
        return 0;
    }
    
    CGRect rect = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil];
    
    return ceil(rect.size.height);
}

@end
