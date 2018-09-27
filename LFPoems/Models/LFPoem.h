//
//  LFPoem.h
//  LFPoems
//
//  Created by Xiangconnie on 15/12/12.
//  Copyright © 2015年 HUST. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, LFPoemType) {
    LFPoemTypeNone = 0, // 无类型
    LFPoemTypeFiveWordQuatrain = 1, // 五言绝句
    LFPoemTypeSevenWordQuatrain = 2, // 七言绝句
    LFPoemTypeFiveWordMetrical = 3, // 五言律诗
    LFPoemTypeSevenWordMetrical = 4, // 七言律诗
    LFPoemTypeFiveWordAncient = 5,  // 五言古诗
    LFPoemTypeSevenWordAncient = 6,  // 七言古诗
    LFPoemTypeYuefu = 7, // 乐府
};

@class LFPoet;

@interface LFPoem : NSObject

@property (nonatomic, assign) NSInteger poemId;
@property (nonatomic, assign) LFPoemType type;
@property (nonatomic, strong) LFPoet *poet;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *comment;
@property (nonatomic, copy) NSString *explanation;

@property (nonatomic, assign) BOOL isFavorite;
@property (nonatomic, assign) BOOL isRecommended;

+ (NSString *)stringFromPoemType:(LFPoemType)type;

@end
