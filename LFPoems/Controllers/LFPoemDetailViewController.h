//
//  LFPoemDetailViewController.h
//  LFPoems
//
//  Created by Xiangconnie on 16/3/6.
//  Copyright © 2016年 HUST. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LFPoem;

// 诗歌详情页: TODO: 不记得当时为啥弄这个和LFPeomDisplayViewController重复了
@interface LFPoemDetailViewController : UIViewController

@property (nonatomic, strong) LFPoem *poem;

+ (instancetype)controllerWithIndex:(NSInteger)index;

@end
