//
//  UITableView+LFCustomize.m
//  PhotoFun
//
//  Created by HUST on 15/7/1.
//  Copyright (c) 2015年 HUST. All rights reserved.
//

#import "UITableView+LFCustomize.h"
#import "UIColor+LFDefault.h"

static const CGFloat LFTableHeaderHeight = 20;
static const CGFloat LFTableFooterHeight = 20;
static const CGFloat LFTableTitleHeaderHeight = 40;

static const NSInteger LFTableHintTextTag = 0x150101;
static const NSInteger LFTableHintViewTag = 0x150102;

@implementation UITableView (LFCustomize)

#pragma mark - Hint View

- (void)showHint:(NSString *)text {
    UILabel *hintView = (UILabel*)[self viewWithTag:LFTableHintTextTag];
    if (!hintView) {
        hintView = [[UILabel alloc]initWithFrame:self.bounds];
        hintView.backgroundColor = [UIColor clearColor];
        hintView.numberOfLines = 0;
        hintView.tag = LFTableHintTextTag;
        hintView.textColor = [UIColor lightGrayColor];
        hintView.font = [UIFont systemFontOfSize:16.0];
        hintView.textAlignment = NSTextAlignmentCenter;
        hintView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
        [self addSubview:hintView];
    }
    
    hintView.text = text;
}

- (void)hideHint {
    UILabel *hintView = (UILabel*)[self viewWithTag:LFTableHintTextTag];
    if (hintView) {
        [hintView removeFromSuperview];
    }
    
    UIView *customHintView = [self viewWithTag:LFTableHintViewTag];
    if (customHintView) {
        [customHintView removeFromSuperview];
    }
}

- (void)showHintView:(UIView *)hintView {
    if (nil == hintView) {
        return;
    }
    
    UIView *addedHintView = [self viewWithTag:LFTableHintViewTag];
    if (addedHintView) {
        return;
    }
    
    hintView.tag = LFTableHintViewTag;
    CGPoint pt = CGPointMake(CGRectGetWidth(self.frame) * 0.5, (CGRectGetHeight(self.frame) - self.contentInset.top) * 0.5);
    hintView.frame = CGRectMake(0, 0, hintView.frame.size.width, hintView.frame.size.height);
    hintView.center = CGPointMake(pt.x, pt.y );
    [self addSubview:hintView];
}

#pragma mark - Seperator Sytle

- (void)setDefaultTableSeparatorStyle {
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.separatorColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
}

- (void)hideExtraCellsLine {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [self setTableFooterView:view];
}

#pragma mark - Header and Footer

- (UIView *)defaultHeaderView {
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor:[UIColor defaultBackgroundColor]];
    return view;
}

- (CGFloat)defaultHeaderHeight {
    return LFTableHeaderHeight;
}

- (UIView* )defaultFooterView {
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor:[UIColor defaultBackgroundColor]];
    return view;
}

- (CGFloat)defaultFooterHeight {
    return LFTableFooterHeight;
}

- (UIView *)defaultHeaderViewWithTitle:(NSString*)title {
    // TODO
    return [self defaultHeaderView];
}

- (CGFloat)defaultTitleHeaderHeight {
    return LFTableTitleHeaderHeight;
}

@end
