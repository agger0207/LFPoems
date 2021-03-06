//
//  LFPoemControlBar.h
//  LFPoems
//
//  Created by Xiangconnie on 15/12/12.
//  Copyright © 2015年 HUST. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LFPoem;

@protocol LFPoemControlBarDelegate <NSObject>

@optional
- (void)moveToNext;

- (void)moveToPrevious;

- (void)play;

- (void)record;

@end

@interface LFPoemControlBar : UIView

@property (nonatomic, weak) id<LFPoemControlBarDelegate> delegate;

- (void)updateWithPoem:(LFPoem *)poem isFirst:(BOOL)isFirst isLast:(BOOL)isLast;

@end
