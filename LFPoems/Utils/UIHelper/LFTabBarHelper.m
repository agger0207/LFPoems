//
//  LFTabBarHelper.m
//  LFPoems
//
//  Created by Wangliping on 15/12/11.
//  Copyright © 2015年 HUST. All rights reserved.
//

#import "LFTabBarHelper.h"
#import "LFTabBarItemData.h"

@implementation LFTabBarHelper

+ (NSArray<UIViewController*> *)tabItemControllers:(NSArray<LFTabBarItemData *> *)itemList {
    NSMutableArray<UIViewController *> *controllerList = [[NSMutableArray alloc] init];
    for (LFTabBarItemData *itemData in itemList) {
        UIViewController *vc = [self tabBarItemController:itemData];
        if (nil != vc) {
            [controllerList addObject:vc];
        }
    }
    
    return controllerList;
}

+ (UIViewController *)tabBarItemController:(LFTabBarItemData *)itemData {
    if (![itemData.itemContentController isSubclassOfClass:[UIViewController class]]) {
        return nil;
    }
    
    UIViewController *contentController = [[itemData.itemContentController alloc] init];
    if (itemData.controllerBlock) {
        itemData.controllerBlock(contentController);
    }
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:contentController];
    navController.tabBarItem = [self tabBarItem:itemData];
    return navController;
}

+ (UITabBarItem *)tabBarItem:(LFTabBarItemData *)itemData {
    UIImage *normalImage = [[UIImage imageNamed:itemData.imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage = [[UIImage imageNamed:itemData.selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:itemData.title image:normalImage selectedImage:selectedImage];
    
    if (itemData.itemBlock) {
        itemData.itemBlock(tabBarItem);
        
        // 例如，可以实现如下的Block来调整图片位置.
        // [tabBarItem setImageInsets:UIEdgeInsetsMake(10, 0, -10, 0)];
    }

    return tabBarItem;
}

@end
