//
//  LFPoemShowViewController.m
//  LFPoems
//
//  Created by Xiangconnie on 16/3/6.
//  Copyright © 2016年 HUST. All rights reserved.
//

#import "LFPoemShowViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "LFPoemDetailViewController.h"
#import "LFPoem.h"
#import "LFPoemControlBar.h"
#import "Masonry.h"

// TODO: 可删除，未使用
@interface LFPoemShowViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate, LFPoemControlBarDelegate>

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) MPMoviePlayerController *playerController;
@property (nonatomic, strong) LFPoemControlBar *controlBar;
@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, assign) BOOL isPlay;
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation LFPoemShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupPlayerController];
    [self setupPageController];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Init UI

- (void)initNavigationItem {
    LFPoem *poem = (LFPoem *)[self.dataList firstObject];
    NSString *title = [poem isKindOfClass:[LFPoem class]] ? poem.title : @"唐诗";
    self.navigationItem.title = title;
    
    [self addLeftButtonWithTitle:@"目录"];
    [self addRightButtonWithTitle:@"收藏"];
}

- (void)setupPageController {
    NSDictionary *options = @{UIPageViewControllerOptionSpineLocationKey:@0,UIPageViewControllerOptionInterPageSpacingKey:@10};
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    
    LFPoemDetailViewController *detailVC = [LFPoemDetailViewController controllerWithIndex:1];
    [self.pageViewController setViewControllers:@[detailVC] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    self.pageViewController.doubleSided = NO;

    self.dataList = [[NSMutableArray alloc] init];
    [self.dataList addObject:detailVC];
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
}

- (void)setupUI {
    [self.view addSubview:self.controlBar];
    
    [self.controlBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.height.mas_equalTo(49);
    }];

    [self.pageViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.bottom.equalTo(self.controlBar.mas_top).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
    }];
}

#pragma mark - Actions

- (void)onClickRightBtn:(id)sender {
    [self play:sender];
}

- (IBAction)play:(id)sender {
    if (!_isPlay) {
        _isPlay = YES;
        [self playCurrentPoem];
    } else {
        _isPlay = NO;
        [self stopCurrentPoem];
    }
}

- (IBAction)moveToNextPage:(id)sender {
    
}

- (IBAction)moveToPrePage:(id)sender {
    
}

/**
 *  跳到选择界面
 *
 *  @param sender 按钮控件
 */
- (IBAction)select:(id)sender {
    
}

/**
 *  调到录制界面。 这里最好是录制和播放另外跳转一个新的界面.
 *
 *  @param sender 按钮控件
 */
- (IBAction)record:(id)sender {
    
}

#pragma mark - Play handle

- (NSURL *)currentPoemURL {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"video" ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:filePath isDirectory:NO];
    return url;
}

- (void)playCurrentPoem {
    NSURL *url = [self currentPoemURL];
    if (nil == url) {
#warning 还未录制
        return;
    }
    
    self.playerController.contentURL = [self currentPoemURL];
    [self.playerController play];
}

- (void)pauseCurrentPoem {
    [self.playerController pause];
}

- (void)stopCurrentPoem {
    [self.playerController stop];
}

- (void)setupPlayerController {
    self.playerController = [[MPMoviePlayerController alloc] init];
    self.playerController.repeatMode = MPMovieRepeatModeOne;
    
#warning 这里是不是不需要额外去添加playerController的view ?
    self.playerController.view.frame = self.view.frame;
    [self.view addSubview:self.playerController.view];
    [self.view sendSubviewToBack:self.playerController.view];
}

- (void)handleAppEnteredForeground {
//    // If the movie player is paused, as it does by default when backgrounded, start
//    // playing again.
//    if (self.moviePlayerController.playbackState == MPMoviePlaybackStatePaused) {
//        [self.moviePlayerController play];
//    }
}

#pragma mark - LFPoemControlBarDelegate

- (void)moveToNext {
    NSUInteger indexOfNextPage = _currentIndex + 1;
    if (indexOfNextPage < [self.dataList count]) {
        [self.pageViewController setViewControllers:@[[self.dataList objectAtIndex:indexOfNextPage]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
}

- (void)moveToPrevious {
    if (_currentIndex == 0) {
        // 已经到了最前面
        return;
    }
    
    NSUInteger indexOfPreviousPage = _currentIndex - 1;
    if (indexOfPreviousPage < [self.dataList count]) {
        [self.pageViewController setViewControllers:@[[self.dataList objectAtIndex:indexOfPreviousPage]] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    }
}

- (void)play {
    if (!_isPlay) {
        _isPlay = YES;
        [self playCurrentPoem];
    } else {
        _isPlay = NO;
        [self stopCurrentPoem];
    }
}

- (void)record {
    
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [self.dataList indexOfObject:viewController];
    if (0 == index) {
        return nil;
    }
    
    return [self.dataList objectAtIndex:index - 1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
//    NSInteger index = [self.dataList indexOfObject:viewController];
//    if (index + 1 >= [self.dataList count]) {
//        return nil;
//    }
//    
//    return [self.dataList objectAtIndex:index + 1];
    
    // TODO: 这里要改成符合自己逻辑的信息. 应该是要在第一次翻阅的时候Load数据. (可以先加100首, 翻到最后一页的时候再加100首，同理，如果是分章节的也是如此处理)
    int index = (int)[_dataList indexOfObject:viewController];
    if (index==9) {
        return nil;
    }else{
        if (_dataList.count-1>=(index+1)) {
            return _dataList[index+1];
        }else{
            LFPoemDetailViewController * model = [LFPoemDetailViewController controllerWithIndex:index+2];
            [_dataList addObject:model];
            return model;
        }
    }
}

// Comment by lwang:
// 技巧：UIPageViewController默认下面会有一排小点；那是因为实现了下面的代理方法.
// 即如果希望使用默认的UIPageControl, 那么就实现下面的方法；
// 否则，注释掉下面的代理方法并且添加自己的UIPageControl.
// 参考：1. http://stackoverflow.com/questions/19935887/how-to-remove-the-bottom-gap-of-uipageviewcontroller
// 其中的答案：UIPageViewController dots are only shown when you have implemented following method:
// 2. http://stackoverflow.com/questions/20748897/hide-dots-from-uipageviewcontroller 列出了原文出处
// 3. https://github.com/mamaral/Onboard 非常棒的首页广告控件, 基于UIPageControl
//- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
//    return 10;
//}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController{
    return 0;
}

#pragma mark - UIPageViewControllerDelegate

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation {
    return UIPageViewControllerSpineLocationMin;
}

#pragma mark - Property 

- (LFPoemControlBar *)controlBar {
    if (nil == _controlBar) {
        _controlBar = [[LFPoemControlBar alloc] initWithFrame:CGRectZero];
        _controlBar.delegate = self;
#ifdef DEBUG
//        _controlBar.backgroundColor = [UIColor purpleColor];

        _controlBar.backgroundColor = [UIColor whiteColor];
#endif
    }
    
    return _controlBar;
}

@end
