//
//  LFPoemBaseTableViewController.h
//  LFPoems
//
//  Created by Xiangconnie on 15/12/12.
//  Copyright © 2015年 HUST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LFPoemBaseTableViewController : UITableViewController

#warning 重复代码
- (void)initNavigationItem;

- (void)addBackButton;

- (void)addLeftButtonWithTitle:(NSString *)title;

- (void)addRightButtonWithTitle:(NSString *)title;

- (void)addRightButtonWithImage:(NSString *)imageName;

@end
