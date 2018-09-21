//
//  NSString+LFCategory.m
//  PhotoFun
//
//  Created by HUST on 15/6/25.
//  Copyright (c) 2015年 HUST. All rights reserved.
//

#import "NSString+LFCategory.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (LFCategory)

- (NSString *)md5String {
    if ([self length] == 0) {
        return @"";
    }
    
    const char *value = [self UTF8String];
    uint8_t digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), digest);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++) {
        [outputString appendFormat:@"%02x", digest[count]];
    }
    
    return outputString;
}

- (BOOL)isContainSubString:(NSString*)str {
    if ([str length] == 0) {
        return NO;
    }
    
    NSRange range = [self rangeOfString:str];
    return (range.location != NSNotFound);
}

- (NSString*)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

@end
