//
//  UITableViewCell+LFCustomize.m
//  PhotoFun
//
//  Created by HUST on 15/7/1.
//  Copyright (c) 2015年 HUST. All rights reserved.
//

#import "UITableViewCell+LFCustomize.h"
#import <objc/runtime.h>

#define SEP_TAG 80999
#define SEP_TOP_TAG 801000
#define SEP_BOTTON_TAG 801001
#define ARROW_RIGHT_TAG 808080
#define DARK_SEP_BOTTON_TAG 708090
#define RIGHT_ARROW_FRAME CGRectMake(296, 13, 10, 18)
#define CHECK_MARK_FRAME CGRectMake(295, 14, 15, 15)

#define SEPEATOR_LEFT_INDENT 15
#define SEPEATOR_H (1/[[UIScreen mainScreen] scale])

const CGFloat LFDefaultCellHeight = 44.0;

typedef enum {
    kCellSeperatorPosTop,
    kCellSeperatorPosBottom,
} CellSeperatorPos;

static const void *keyClearBg = &keyClearBg;

@interface UITableViewCell()

@property (nonatomic, assign) BOOL mIsClearBg;

@end

@implementation UITableViewCell (LFCustomize)

#pragma mark - Property

- (BOOL)mIsClearBg {
    NSNumber *num = objc_getAssociatedObject(self, keyClearBg);
    return [num boolValue];
}

- (void)setMIsClearBg:(BOOL)isClear{
    objc_setAssociatedObject(self, keyClearBg, @(isClear), OBJC_ASSOCIATION_RETAIN);
}

#pragma mark - Set Background

- (void)setBackgroundImage:(UIImage*)image {
    if (!image) {
        return;
    }
    
    UIImageView *bg = [[UIImageView alloc] initWithImage:image];
    self.backgroundView = bg;
}

- (void)setSelectImage:(UIImage*)image {
    if (!image) {
        return;
    }
    
    UIImageView* selbg = [[UIImageView alloc] initWithImage:image];
    self.selectedBackgroundView = selbg;
}

- (void)setDefaultBackground:(BOOL)isForeground {
    if (self.mIsClearBg) {
        return;
    }
    
    // TODO
    //    if (hasForeground) {
    //        [self setBackgroundImage:[UIImage cellNormalImage]];
    //    }
    //
    //    [self setSelectImage:[UIImage cellHightLightImage]];
}

//- (void)customTableCellByType:(CellColorType)type {
//    self.backgroundColor = [UIColor whiteColor];
//    [self setBackgroundByType:type hasForeground:NO];
//}

- (void) setBackgroundColorWithoutBounds {
    self.backgroundColor = [UIColor whiteColor];
    
//    UIImageView *selBg	= [[UIImageView alloc] initWithFrame:self.frame];
//    selBg.backgroundColor = [UIColor colorWithRed:FFCOLOR2FLOAT(217)
//                                            green:FFCOLOR2FLOAT(217)
//                                             blue:FFCOLOR2FLOAT(217)
//                                            alpha:1];
//    self.selectedBackgroundView = selBg;
}

- (void)setClearBg {
    self.mIsClearBg = YES;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setBackgroundColor:[UIColor clearColor]];
    [self setBackgroundView:[[UIView alloc] init]];
}

#pragma mark - Seperator

- (UIView*)seperator {
    return [self viewWithTag:SEP_TAG];
}

- (void)addSeperator {
    if ([self viewWithTag:SEP_TAG] != nil) {
        return;
    }
    
    [self setSeperatorFrame:[self frameFullWidthForPostion:kCellSeperatorPosBottom] tag:SEP_TAG];
}

- (void)addTopSeperator {
    if ([self viewWithTag:SEP_TOP_TAG] != nil) {
        return;
    }
    
    [self setSeperatorFrame:[self frameFullWidthForPostion:kCellSeperatorPosTop] tag:SEP_TOP_TAG pos:kCellSeperatorPosTop];
}

- (void)addShortSeperator {
    if ([self viewWithTag:SEP_TAG] != nil) {
        return;
    }
    
    [self setSeperatorFrame:[self frameLeftIndentForPostion:kCellSeperatorPosBottom] tag:SEP_TAG pos:kCellSeperatorPosBottom];
}

- (void)addShortSeperatorWithRightIndent:(CGFloat)rightIndent {
    if ([self viewWithTag:SEP_TAG] != nil) {
        return;
    }
    
    [self setSeperatorFrame:[self frameForPostion:kCellSeperatorPosBottom leftIndent:SEPEATOR_LEFT_INDENT rightIndent:rightIndent] tag:SEP_TAG pos:kCellSeperatorPosBottom];
}

- (void)addCustomSeperator:(int)startX {
    if ([self viewWithTag:SEP_TAG] != nil) {
        return;
    }
    
    [self setSeperatorFrame:[self frameCustomWithStartX:startX ForPostion:kCellSeperatorPosBottom] tag:SEP_TAG];
}

- (void) setSeperatorHidde:(BOOL)hidden{
    [[self viewWithTag:SEP_TAG] setHidden:hidden];
    [[self viewWithTag:SEP_BOTTON_TAG] setHidden:hidden];
    [[self viewWithTag:SEP_TOP_TAG] setHidden:hidden];
}

- (void)removeSeperator {
    [[self viewWithTag:SEP_TAG] removeFromSuperview];
    [[self viewWithTag:SEP_BOTTON_TAG] removeFromSuperview];
    [[self viewWithTag:SEP_TOP_TAG] removeFromSuperview];
}

- (CGRect)frameNullForPostion:(CellSeperatorPos)pos {
    return CGRectMake(0, 0, 0, 0);
}

- (CGRect)frameLeftIndentForPostion:(CellSeperatorPos)pos {
    return [self frameCustomWithStartX:SEPEATOR_LEFT_INDENT ForPostion:pos];
}

- (CGRect)frameForPostion:(CellSeperatorPos)pos leftIndent:(CGFloat)leftIndent rightIndent:(CGFloat)rightIndent {
    return [self frameCustomWithStartX:leftIndent rightIndent:rightIndent ForPostion:pos];
}

- (CGRect)frameFullWidthForPostion:(CellSeperatorPos)pos {
    return [self frameCustomWithStartX:0 ForPostion:pos];
}

- (CGRect)frameCustomWithStartX:(int)startX ForPostion:(CellSeperatorPos)pos {
    CGRect rect;
    if (kCellSeperatorPosBottom == pos) {
        rect = CGRectMake(startX, self.bounds.size.height - 1, self.bounds.size.width - startX, 1);
    } else if (kCellSeperatorPosTop == pos) {
        rect = CGRectMake(startX, 0, self.bounds.size.width - startX, 1);
    }
    
    return rect;
}

- (CGRect)frameCustomWithStartX:(int)startX rightIndent:(CGFloat)rightIndent ForPostion:(CellSeperatorPos)pos {
    CGRect rect;
    if (kCellSeperatorPosBottom == pos) {
        rect = CGRectMake(startX, self.bounds.size.height - 1, self.bounds.size.width - startX - rightIndent, 1);
    } else if (kCellSeperatorPosTop == pos) {
        rect = CGRectMake(startX, 0, self.bounds.size.width - startX - rightIndent, 1);
    }
    
    return rect;
}

- (void)setSeperatorFrame:(CGRect)frame tag:(int)tag {
    [self setSeperatorFrame:frame tag:tag pos:kCellSeperatorPosBottom];
}

- (void)setSeperatorFrame:(CGRect)frame tag:(int)tag pos:(CellSeperatorPos)pos {
    UIView* seperator = [self viewWithTag:tag];
    if (!seperator) {
        UIImageView* imgView = [[UIImageView alloc] init];
        imgView.tag = tag;
        
        if (kCellSeperatorPosTop == pos) {
            imgView.image = [UIImage imageNamed:[self defaultUpSeperatorImage]];
            imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        }
        else {
            imgView.image = [UIImage imageNamed:[self defaultDownSeperatorImage]];
            imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        }
        [self addSubview:imgView];
        
        seperator = imgView;
    }
    
    if (frame.size.width == 0) {
        seperator.hidden = YES;
        return;
    }
    
    seperator.hidden = NO;
    seperator.frame = frame;
}

- (void)customGroupedSeperator:(NSInteger)total row:(NSInteger)row {
    [self customGroupedSeperator:total row:row startX:SEPEATOR_LEFT_INDENT];
}

- (void)customGroupedFullWidthSeperator:(NSInteger)total row:(NSInteger)row {
    [self customGroupedSeperator:total row:row startX:0];
}

- (void)customGroupedSeperator:(NSInteger)total row:(NSInteger)row startX:(int) startx {
    if (self.mIsClearBg) {
        return;
    }
    
    NSArray* arrayFrame = nil;
    if (total == 1) {
        arrayFrame = @[[NSValue valueWithCGRect:[self frameFullWidthForPostion:kCellSeperatorPosTop]], [NSValue valueWithCGRect:[self frameFullWidthForPostion:kCellSeperatorPosBottom]]];
    } else {
        if (row == 0) {
            arrayFrame = @[[NSValue valueWithCGRect:[self frameFullWidthForPostion:kCellSeperatorPosTop]], [NSValue valueWithCGRect:[self frameCustomWithStartX:startx ForPostion:kCellSeperatorPosBottom]]];
        } else if(row == total - 1) {
            arrayFrame = @[[NSValue valueWithCGRect:[self frameNullForPostion:kCellSeperatorPosTop]], [NSValue valueWithCGRect:[self frameFullWidthForPostion:kCellSeperatorPosBottom]]];
        } else {
            arrayFrame = @[[NSValue valueWithCGRect:[self frameNullForPostion:kCellSeperatorPosTop]], [NSValue valueWithCGRect:[self frameCustomWithStartX:startx ForPostion:kCellSeperatorPosBottom]]];
        }
    }
    
    NSAssert([arrayFrame count] == 2, nil);
    [self setSeperatorFrame:[arrayFrame[0] CGRectValue] tag:SEP_TOP_TAG pos:kCellSeperatorPosTop];
    [self setSeperatorFrame:[arrayFrame[1] CGRectValue] tag:SEP_BOTTON_TAG pos:kCellSeperatorPosBottom];
}

#pragma mark - Custom Right Arrow

- (void)addRightArrow {
    [self addRightArrowWithImage:[self defaultRightArrowImage]];
}

- (void)addRightArrowWithImage:(NSString*)imageName {
    self.accessoryType = UITableViewCellAccessoryNone;
    UIView *arrowView = [self viewWithTag:ARROW_RIGHT_TAG];
    if (!arrowView) {
        UIImageView * arrowImageView = [[UIImageView alloc]init];
        arrowView = arrowImageView;
        
        arrowImageView.tag = ARROW_RIGHT_TAG;
        arrowImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        CGRect arrowRect = RIGHT_ARROW_FRAME;
        CGRect cellRect = self.bounds;
        arrowRect.origin.y = (CGRectGetHeight(cellRect) - CGRectGetHeight(arrowRect)) / 2;
        arrowImageView.frame = arrowRect;
        arrowImageView.image = [UIImage imageNamed:imageName];
        [self addSubview:arrowImageView];
    }
    
    if (arrowView) {
        arrowView.hidden = NO;
    }
}

- (void)hiddenRightArrow {
    UIView* arrowImageView = [self viewWithTag:ARROW_RIGHT_TAG];
    [arrowImageView setHidden:YES];
}

#pragma mark - Custom Check Mark

- (void)addCheckMark {
    [self addCheckMarkWithImage:[self defaultCheckMarkImage]];
}

- (void)addCheckMarkWithImage:(NSString*)imageName {
    self.accessoryType = UITableViewCellAccessoryNone;
    UIView *checkMarkView = self.accessoryView;
    if (!checkMarkView) {
        UIImageView * checkMarkImageView = [[UIImageView alloc]init];
        checkMarkView = checkMarkImageView;
        
        checkMarkImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        CGRect checkMarkRect = [self defaultCheckMarkFrame];
        CGRect cellRect = self.bounds;
        checkMarkRect.origin.y = (CGRectGetHeight(cellRect) - CGRectGetHeight(checkMarkRect)) / 2;
        checkMarkImageView.frame = checkMarkRect;
        checkMarkImageView.image = [UIImage imageNamed:imageName];
        self.accessoryView = checkMarkImageView;
    }
    
    if (checkMarkView) {
        checkMarkView.hidden = NO;
    }
}

- (void)hideCheckMark {
    self.accessoryType = UITableViewCellAccessoryNone;
    self.accessoryView = nil;
}

#pragma mark - Default Subview Property

- (CGRect)defaultRightArrowFrame {
    return RIGHT_ARROW_FRAME;
}

- (CGRect)defaultCheckMarkFrame {
    return CHECK_MARK_FRAME;
}

- (NSString *)defaultRightArrowImage {
    return @"arrow_right_default.png";
}

- (NSString *)defaultCheckMarkImage {
    return @"ico_selected";
}

- (NSString *)defaultUpSeperatorImage {
    return @"import_foot_line_up.png";
}

- (NSString*)defaultDownSeperatorImage {
    return @"import_foot_line_down.png";
}

+ (CGFloat)defaultRowHeight {
    return LFDefaultCellHeight;
}

@end
