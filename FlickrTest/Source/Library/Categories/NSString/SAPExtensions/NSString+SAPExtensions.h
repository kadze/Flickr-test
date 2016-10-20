//
//  SAPStringAdditions.h
//  MacCourse
//
//  Created by S A P on 11/24/15.
//  Copyright © 2015 Yosemite Retail. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIFont.h>

@interface NSString (SAPExtensions)

+ (instancetype)alphanumericAlphabet;
+ (instancetype)numericAlphabet;
+ (instancetype)letterAlphabet;
+ (instancetype)lowerCaseLetterAlphabet;
+ (instancetype)capitalizedCaseLetterAlphabet;
+ (instancetype)alphabetWithUnicodeRange:(NSRange)range;

+ (instancetype)randomStringWithAlphabetString:(NSString *)alphabet length:(NSUInteger)length;

- (instancetype)randomStringFromSelfOfLength:(NSUInteger)length;
- (instancetype)stringByReplacingOccurrencesOfKeysWithValuesInDictionary:(NSDictionary *)dictionary;

- (CGFloat)heigthWithFont:(UIFont *)font width:(CGFloat)width;

@end
