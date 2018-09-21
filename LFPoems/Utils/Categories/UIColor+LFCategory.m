//
//  UIColor+LFCategory.m
//  PhotoFun
//
//  Created by HUST on 15/6/30.
//  Copyright (c) 2015年 HUST. All rights reserved.
//

#import "UIColor+LFCategory.h"

@implementation UIColor (LFCategory)

+ (UIColor *)colorWithHexValue:(long)colorInHex {
    return [self colorWithHexValue:colorInHex alpha:1.0];
}

+ (UIColor *)colorWithHexValue:(long)colorInHex alpha:(CGFloat)alpha {
    return [self colorWithRed:((CGFloat) ((colorInHex & 0xFF0000) >> 16)) / 0xFF
                        green:((CGFloat) ((colorInHex & 0xFF00)   >> 8))  / 0xFF
                         blue:((CGFloat)  (colorInHex & 0xFF)) / 0xFF
                        alpha:alpha];
}

+ (UIColor *)colorWithAbsoluteRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    return [self colorWithRed:(CGFloat)(red / 255.0f)  green:(CGFloat)(green / 255.0f) blue:(CGFloat)(blue / 255.0f) alpha:alpha];
}

@end
