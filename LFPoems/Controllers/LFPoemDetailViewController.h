//
//  LFPoemDetailViewController.h
//  LFPoems
//
//  Created by Xiangconnie on 16/3/6.
//  Copyright © 2016年 HUST. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LFPoem;

@interface LFPoemDetailViewController : UIViewController

@property (nonatomic, strong) LFPoem *poem;

+ (instancetype)controllerWithIndex:(NSInteger)index;

@end
