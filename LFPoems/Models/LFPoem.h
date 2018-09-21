//
//  LFPoem.h
//  LFPoems
//
//  Created by Xiangconnie on 15/12/12.
//  Copyright © 2015年 HUST. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, LFPoemType) {
    LFPoemTypeFiveMetrical = 1,
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

+ (NSString *)stringFromPoemType:(LFPoemType)type;

@end
