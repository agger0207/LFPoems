//
//  UIViewControllerHelper.m
//  PhotoFun
//
//  Created by HUST on 15/6/24.
//  Copyright (c) 2015年 HUST. All rights reserved.
//

#import "LFUITabBarHelper.h"
#import "LFTabBarItemData.h"
#import "LFPoemsConfig.h"
#import "LFTabBarHelper.h"
#import "LFPHomeViewContorller.h"
#import "LFPFavoriteViewController.h"
#import "LFPSearchViewController.h"
#import "LFPSettingViewController.h"
#import "LFPRandomViewController.h"

@implementation LFUITabBarHelper

#pragma mark - Get Tab bar Item Controller

+ (NSArray<UIViewController*> *)tabItemControllers:(NSArray<NSNumber *> *)itemTagList {
    NSMutableArray<LFTabBarItemData *> *itemDataList = [[NSMutableArray alloc] init];
    for (NSNumber *tag in itemTagList) {
        LFTabBarItemData *itemData = [self tabBarItemDataWithTag:tag.integerValue];
        if (nil != itemData) {
            [itemDataList addObject:itemData];
        }
    }
    
    return [LFTabBarHelper tabItemControllers:itemDataList];
}

+ (LFTabBarItemData *)tabBarItemDataWithTag:(NSInteger)tag {
    LFTabBarItemData *tabBarItemData = [[LFTabBarItemData alloc] init];
    switch (tag) {
        case LFTabItemTagMain:
            tabBarItemData.title = NSLocalizedString(@"精选", nil);
            tabBarItemData.imageName = @"home";
            tabBarItemData.selectedImageName = @"home_selected";
            tabBarItemData.itemContentController = [LFPHomeViewContorller class];
            break;
            
        case LFTabItemTagSearch:
            tabBarItemData.title = NSLocalizedString(@"全唐诗", nil);
            tabBarItemData.imageName = @"home";
            tabBarItemData.selectedImageName = @"home_selected";
            tabBarItemData.itemContentController = [LFPSearchViewController class];
            break;
            
        case LFTabItemTagFavorite:
            tabBarItemData.title = NSLocalizedString(@"收藏", nil);
            tabBarItemData.imageName = @"home";
            tabBarItemData.selectedImageName = @"home_selected";
            tabBarItemData.itemContentController = [LFPFavoriteViewController class];
            break;
            
        case LFTabItemTagRandom:
            tabBarItemData.title = NSLocalizedString(@"今日推荐", nil);
            tabBarItemData.imageName = @"cart";
            tabBarItemData.selectedImageName = @"cart_selected";
            tabBarItemData.itemContentController = [LFPRandomViewController class];
            break;
            
        case LFTabItemTagSetting:
            tabBarItemData.title = NSLocalizedString(@"关于", nil);
            tabBarItemData.imageName = @"mine";
            tabBarItemData.selectedImageName = @"mine_selected";
            tabBarItemData.itemContentController = [LFPSettingViewController class];
            break;
            
        default:
            break;
    }
    
    return tabBarItemData;
}

@end
