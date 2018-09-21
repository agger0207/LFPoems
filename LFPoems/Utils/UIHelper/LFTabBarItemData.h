//
//  LFTabBarItemData.h
//  PhotoFun
//
//  Created by HUST on 15/6/24.
//  Copyright (c) 2015年 HUST. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UITabBarItem;
@class UIViewController;

typedef void(^LFCustomTabBarItemBlock)(UITabBarItem *tabBarItem);
typedef void(^LFCustomItemControllerBlock)(UIViewController *vc);

@interface LFTabBarItemData : NSObject

/**
 *  Tab bar Item的title.
 */
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *selectedImageName;
@property (nonatomic, strong) Class itemContentController;
@property (nonatomic, copy) LFCustomTabBarItemBlock itemBlock;
@property (nonatomic, copy) LFCustomItemControllerBlock controllerBlock;

@end
