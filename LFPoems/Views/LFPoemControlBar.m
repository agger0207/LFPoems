//
//  LFPoemControlBar.m
//  LFPoems
//
//  Created by Xiangconnie on 15/12/12.
//  Copyright © 2015年 HUST. All rights reserved.
//

#import "LFPoemControlBar.h"
#import "Masonry.h"

static const CGFloat kPadding = 10;
static const CGFloat kWidth = 64;

@interface LFPoemControlBar ()

@property (nonatomic, strong) UIButton *prevBtn;
@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, strong) UIButton *recordBtn;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) LFPoem *poem;
@property (nonatomic, assign) BOOL isFirst;
@property (nonatomic, assign) BOOL isLast;

@end

@implementation LFPoemControlBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - Layout
//
//- (void)layoutSubviews {
//    [super layoutSubviews];
//    
//    _prevBtn.frame = CGRectMake(100, 0, kWidth, self.frame.size.height);
//    _playBtn.frame = CGRectMake(CGRectGetMaxX(_prevBtn.frame) + kPadding, 0, kWidth, self.frame.size.height);
//    _recordBtn.frame = CGRectMake(CGRectGetMaxX(_playBtn.frame) + kPadding, 0, kWidth, self.frame.size.height);
//    _nextBtn.frame = CGRectMake(CGRectGetMaxX(_recordBtn.frame) + kPadding, 0, kWidth, self.frame.size.height);
//}

#pragma mark - Setup UI

- (void)setupUI {
    _prevBtn = [self generateButtonWithTitle:@"前一首"];
//    _playBtn = [self generateButtonWithTitle:@"播放"];
//    _recordBtn = [self generateButtonWithTitle:@"录制"];
    _nextBtn = [self generateButtonWithTitle:@"下一首"];
    
    [_prevBtn addTarget:self action:@selector(onPreBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [_playBtn addTarget:self action:@selector(onPlayBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [_recordBtn addTarget:self action:@selector(onRecordBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_nextBtn addTarget:self action:@selector(onNextBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_prevBtn];
//    [self addSubview:_playBtn];
//    [self addSubview:_recordBtn];
    [self addSubview:_nextBtn];
    
//    NSArray *btnList = @[_prevBtn, _playBtn, _recordBtn, _nextBtn];
    NSArray *btnList = @[_prevBtn, _nextBtn];
    [btnList mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:kPadding leadSpacing:kPadding tailSpacing:kPadding];
    [btnList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(0);
        make.height.mas_equalTo(self.mas_height);
    }];
}

#pragma mark - UI Buttons

- (UIButton *)generateButtonWithTitle:(NSString *)title {
#warning 播放
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
    button.titleLabel.textColor = [UIColor blackColor];
    button.opaque = YES;
    
    return button;
}

- (UIButton *)generateButtonWithImage:(NSString *)image {
#warning 创建
    return nil;
}

#pragma mark - Actions

- (IBAction)onPreBtnClicked:(id)sender {
    if ([_delegate respondsToSelector:@selector(moveToPrevious)]) {
        [_delegate moveToPrevious];
    }
}

- (IBAction)onPlayBtnClicked:(id)sender {
    if ([_delegate respondsToSelector:@selector(play)]) {
        [_delegate play];
    }
}

- (IBAction)onRecordBtnClicked:(id)sender {
    if ([_delegate respondsToSelector:@selector(record)]) {
        [_delegate record];
    }
}

- (IBAction)onNextBtnClicked:(id)sender {
    if ([_delegate respondsToSelector:@selector(moveToNext)]) {
        [_delegate moveToNext];
    }
}

#pragma mark - Public Methods

- (void)updateWithPoem:(LFPoem *)poem isFirst:(BOOL)isFirst isLast:(BOOL)isLast {
    self.prevBtn.enabled = !isFirst;
    self.nextBtn.enabled = !isLast;
    self.poem = poem;
    self.isFirst = isFirst;
    self.isLast = isLast;
}

@end
