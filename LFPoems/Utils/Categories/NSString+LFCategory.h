//
//  NSString+LFCategory.h
//  PhotoFun
//
//  Created by WangLiping on 15/6/25.
//  Copyright (c) 2015年 HUST. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (LFCategory)

- (NSString *)md5String;

- (BOOL)isContainSubString:(NSString*)str;

- (NSString*)trim;

@end
