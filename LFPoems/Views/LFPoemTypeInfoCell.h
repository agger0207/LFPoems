//
//  LFPoemTypeInfoCell.h
//  LFPoems
//
//  Created by Xiangconnie on 15/12/12.
//  Copyright © 2015年 HUST. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LFPoem;

@interface LFPoemTypeInfoCell : UITableViewCell

- (void)updateWithPoem:(LFPoem *)poem;

+ (NSString *)cellIdentifier;

@end
