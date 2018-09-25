//
//  LFPoemBaseViewController.h
//  LFPoems
//
//  Created by Xiangconnie on 15/12/12.
//  Copyright © 2015年 HUST. All rights reserved.
//

#import <UIKit/UIKit.h>

// 各Tab页的基类
@interface LFPoemBaseViewController : UIViewController

- (void)initNavigationItem;

- (void)addBackButton;

- (void)addLeftButtonWithTitle:(NSString *)title;

- (void)addRightButtonWithTitle:(NSString *)title;

- (void)addRightButtonWithImage:(NSString *)imageName;

@end
