//
//  LFUIStyleHelper.m
//  PhotoFun
//
//  Created by HUST on 15/6/30.
//  Copyright (c) 2015年 HUST. All rights reserved.
//

#import "LFUIStyleHelper.h"
#import "UIColor+LFCategory.h"

@implementation LFUIStyleHelper

+ (void)customizeTabBarStyle {
    [[UITabBar appearance] setTintColor:[UIColor colorWithHexValue:0xD22147]];
    if ([UITabBar instancesRespondToSelector:@selector(setBarTintColor:)]) {
        [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    }
    
    UIColor *titleNormalColor = [UIColor colorWithHexValue:0x333333];
    UIColor *titleSelectedColor = [UIColor colorWithHexValue:0xD22147];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10.0f],
                                                        NSForegroundColorAttributeName: titleNormalColor}
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10.0f],
                                                        NSForegroundColorAttributeName: titleSelectedColor}
                                             forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0.0f, -2.0f)];
}

+ (void)customizeNavigationBarStyle {
    //定制导航栏风格
    [[UINavigationBar appearance] setBackgroundColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor],
                                                           NSFontAttributeName: [UIFont systemFontOfSize:18.0f]}];
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
}

@end
