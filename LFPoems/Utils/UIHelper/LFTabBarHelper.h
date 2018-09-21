//
//  LFTabBarHelper.h
//  LFPoems
//
//  Created by Wangliping on 15/12/11.
//  Copyright © 2015年 HUST. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class LFTabBarItemData;

@interface LFTabBarHelper : NSObject

+ (NSArray<UIViewController*> *)tabItemControllers:(NSArray<LFTabBarItemData *> *)itemList;

@end
