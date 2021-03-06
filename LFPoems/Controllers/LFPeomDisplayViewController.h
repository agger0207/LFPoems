//
//  LFPeomDisplayViewController.h
//  LFPoems
//
//  Created by Xiangconnie on 15/12/12.
//  Copyright © 2015年 HUST. All rights reserved.
//

#import "LFPoemBaseViewController.h"

@class LFPoem;

@protocol LFPoemActionDelegate <NSObject>

- (LFPoem *)poemAtIndex:(NSIndexPath *)index;

- (NSIndexPath *)nextIndex:(NSIndexPath *)index;

- (NSIndexPath *)prevIndex:(NSIndexPath *)index;

@required
- (BOOL)isLastIndex:(NSIndexPath *)index;

@required
- (BOOL)isFirstIndex:(NSIndexPath *)index;

@end

// 诗歌内容展示页
@interface LFPeomDisplayViewController : LFPoemBaseViewController

@property (nonatomic, strong) LFPoem *poem;
@property (nonatomic, strong) NSIndexPath *index;
@property (nonatomic, weak) id<LFPoemActionDelegate> poemDelegate;

@end
