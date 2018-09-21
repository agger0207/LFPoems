//
//  LFPoemTestHelper.h
//  LFPoems
//
//  Created by Xiangconnie on 15/12/12.
//  Copyright © 2015年 HUST. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LFPoet;
@class LFPoem;

@interface LFPoemTestHelper : NSObject

+ (NSArray *)poetsForTest;

+ (NSDictionary *)poemsForTest;

+ (NSArray *)favoritePoemsForTest;

+ (NSArray *)filterPoemsForTest;

+ (LFPoem *)poemForTest;

@end
