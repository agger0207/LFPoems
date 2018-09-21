//
//  LFPoemContentCell.h
//  LFPoems
//
//  Created by Xiangconnie on 15/12/12.
//  Copyright © 2015年 HUST. All rights reserved.
//

#import "LFPoemDetailBaseCell.h"

@class LFPoem;

@interface LFPoemContentCell : LFPoemDetailBaseCell

- (void)updateWithPoem:(LFPoem *)poem;

- (CGFloat)height;

@end
