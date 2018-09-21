//
//  LFPoemTestHelper.m
//  LFPoems
//
//  Created by Xiangconnie on 15/12/12.
//  Copyright © 2015年 HUST. All rights reserved.
//

#import "LFPoemTestHelper.h"
#import "LFPoem.h"
#import "LFPoet.h"

@implementation LFPoemTestHelper

+ (NSDictionary *)poemsForTest {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSArray *poets = [self poetsForTest];
    for (LFPoet *poet in poets) {
        NSMutableArray *poems = [NSMutableArray array];
        for (int i = 0; i < 18; i ++) {
            LFPoem *poem = [[LFPoem alloc] init];
            poem.title = @"静夜思";
            poem.type = LFPoemTypeFiveMetrical;
            poem.poet = [[LFPoet alloc] init];
            poem.poet.name = @"李白";
            poem.isFavorite = YES;
            [poems addObject:poem];
        }

        [dic setObject:poems forKey:poet.name];
    }
    
    return dic;
}

+ (NSArray *)poetsForTest {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 30; i ++) {
        LFPoet *poet = [[LFPoet alloc] init];
        poet.name = [NSString stringWithFormat:@"李白%d", i];
        [array addObject:poet];
    }
    
    return array;
}

+ (NSArray *)favoritePoemsForTest {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 30; i ++) {
        LFPoem *poem = [[LFPoem alloc] init];
        poem.title = @"静夜思";
        poem.type = LFPoemTypeFiveMetrical;
        poem.poet = [[LFPoet alloc] init];
        poem.poet.name = @"李白";
        poem.isFavorite = YES;
        [array addObject:poem];
    }
    
    return array;
}

+ (NSArray *)filterPoemsForTest {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 10; i ++) {
        LFPoem *poem = [[LFPoem alloc] init];
        poem.title = @"春晓";
        poem.type = LFPoemTypeFiveMetrical;
        poem.poet = [[LFPoet alloc] init];
        poem.poet.name = @"孟浩然";
        poem.isFavorite = YES;
        [array addObject:poem];
    }
    
    return array;
}

+ (LFPoem *)poemForTest {
    LFPoem *poem = [[LFPoem alloc] init];
    poem.title = @"静夜思";
    poem.type = LFPoemTypeFiveMetrical;
    poem.poet = [[LFPoet alloc] init];
    poem.poet.name = @"李白";
    poem.isFavorite = YES;
    
    return poem;
}

@end
