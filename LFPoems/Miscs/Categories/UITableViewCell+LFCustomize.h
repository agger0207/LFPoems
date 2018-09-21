//
//  UITableViewCell+LFCustomize.h
//  PhotoFun
//
//  Created by HUST on 15/7/1.
//  Copyright (c) 2015年 HUST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (LFCustomize)

// TODO: 参数命名要改
- (void)setDefaultBackground:(BOOL)isForeground;

//custome set cell backgroundview and selectview
-(void) setBackgroundImage:(UIImage*)image;
-(void) setSelectImage:(UIImage*)image;

/*
 seperator
 */
- (void) addSeperator;
- (void) addTopSeperator;
- (UIView*) seperator;
- (void) addShortSeperator;
- (void) addCustomSeperator:(int) startX;

// 在addShortSeperator的基础上加上右边距
- (void) addShortSeperatorWithRightIndent:(CGFloat)rightIndent;

/**
 *	@brief	将多个section设置中间的行距离左边15px分割线
 *
 *	@param 	total 	当前section总行数
 *	@param 	row     当前行数
 */
- (void)customGroupedSeperator:(NSInteger)total row:(NSInteger)row;

/**
 *	@brief	将多个section设置中间的行距离左边startx px分割线
 *
 *	@param 	total 	当前section总行数
 *	@param 	row     当前行数
 *	@param 	startx  中间行分割线的起点
 */
- (void)customGroupedSeperator:(NSInteger)total row:(NSInteger)row startX:(int) startx;

/**
 *	@brief	将多个section设置中间的行全宽分割线
 *
 *	@param 	total 	当前section总行数
 *	@param 	row     当前行数
 */
- (void)customGroupedFullWidthSeperator:(NSInteger)total row:(NSInteger)row;

- (void) setSeperatorHidde:(BOOL)hidden;
- (void) removeSeperator;

- (void) setClearBg;

- (void)addRightArrow;

- (void)addCheckMark;

+ (CGFloat)defaultRowHeight;

@end
