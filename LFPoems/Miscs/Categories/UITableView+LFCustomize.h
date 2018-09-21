//
//  UITableView+LFCustomize.h
//  PhotoFun
//
//  Created by HUST on 15/7/1.
//  Copyright (c) 2015年 HUST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (LFCustomize)

- (void)showHint:(NSString *)text;

- (void)hideHint;

- (void)showHintView:(UIView *)hintView;

// 默认不使用系统的分隔线
- (void)setDefaultTableSeparatorStyle;

// 在PlainStyle下使用系统分隔线时, 隐藏掉不显示内容的Cell的分隔线.
- (void)hideExtraCellsLine;

// 默认Header与Footer
- (UIView *)defaultHeaderView;
- (CGFloat)defaultHeaderHeight;

- (UIView *)defaultFooterView;
- (CGFloat)defaultFooterHeight;

- (UIView *)defaultHeaderViewWithTitle:(NSString*)title;
- (CGFloat)defaultTitleHeaderHeight;

@end
