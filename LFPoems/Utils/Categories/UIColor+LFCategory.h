//
//  UIColor+LFCategory.h
//  PhotoFun
//
//  Created by HUST on 15/6/30.
//  Copyright (c) 2015年 HUST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (LFCategory)

+ (UIColor *)colorWithHexValue:(long)colorInHex;

+ (UIColor *)colorWithHexValue:(long)colorInHex alpha:(CGFloat)alpha;

+ (UIColor *)colorWithAbsoluteRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

@end
