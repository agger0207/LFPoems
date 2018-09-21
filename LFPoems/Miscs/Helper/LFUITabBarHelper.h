//
//  UIViewControllerHelper.h
//  PhotoFun
//
//  Created by HUST on 15/6/24.
//  Copyright (c) 2015年 HUST. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class LFTabBarItemData;

@interface LFUITabBarHelper : NSObject

+ (NSArray<UIViewController*> *)tabItemControllers:(NSArray<NSNumber *> *)itemTagList;

+ (LFTabBarItemData *)tabBarItemDataWithTag:(NSInteger)tag;


@end
