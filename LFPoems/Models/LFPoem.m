//
//  LFPoem.m
//  LFPoems
//
//  Created by Xiangconnie on 15/12/12.
//  Copyright © 2015年 HUST. All rights reserved.
//

#import "LFPoem.h"

@implementation LFPoem

#pragma mark - Helper Methods

+ (NSString *)stringFromPoemType:(LFPoemType)type {
    NSString *typeDescription;
    switch (type) {
        case LFPoemTypeFiveWordQuatrain:
            typeDescription = @"五言绝句";
            break;
            
        case LFPoemTypeSevenWordQuatrain:
            typeDescription = @"七言绝句";
            break;
            
        case LFPoemTypeFiveWordMetrical:
            typeDescription = @"五言律诗";
            break;
            
        case LFPoemTypeSevenWordMetrical:
            typeDescription = @"七言律诗";
            break;
            
        case LFPoemTypeFiveWordAncient:
            typeDescription = @"五言古诗";
            break;
            
        case LFPoemTypeSevenWordAncient:
            typeDescription = @"七言古诗";
            break;
            
        case LFPoemTypeYuefu:
            typeDescription = @"乐府";
            break;
            
        default:
            typeDescription = @"";
            break;
    }
    
    return typeDescription;
}

+ (NSArray<NSString *> *) poets {
    return @[@"孟浩然", @"李白", @"杜甫", @"王维", @"王昌龄", @"王之涣", @"李商隐", @"杜牧", @"白居易", @"岑参", @"柳宗元", @"韩愈", @"崔颢", @"刘禹锡", @"韦应物", @"贺知章", @"其他"];
}

+ (BOOL)isFamousPoet:(NSString *)poetName {
    return [self.poets containsObject:poetName];
}

@end
