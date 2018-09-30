//
//  PFMainViewController.m
//  PhotoFun
//
//  Created by Wangliping on 15/6/24.
//  Copyright (c) 2015年 HUST. All rights reserved.
//

#import "LFMainTabBarController.h"
#import "LFPoemsConfig.h"
#import "LFUITabBarHelper.h"
#import "LFUIStyleHelper.h"

@interface LFMainTabBarController ()

@end

@implementation LFMainTabBarController

#pragma mark - Life Cycle

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initUISetting];
    }
    
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initUISetting];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Init UI Setting

- (void)initUISetting {
    [self initUIStyle];
    [self initTabBarItems];
}

#pragma mark - Init TabBar Items

- (void)initTabBarItems {
    NSArray *tags = @[@(LFTabItemTagMain), @(LFTabItemTagRandom),  @(LFTabItemTagFavorite), @(LFTabItemTagSearch), @(LFTabItemTagSetting)];
    self.viewControllers = [LFUITabBarHelper tabItemControllers:tags];
}

#pragma mark - Init Global UI Style

- (void)initUIStyle {
    [LFUIStyleHelper customizeTabBarStyle];
    [LFUIStyleHelper customizeNavigationBarStyle];
}

@end
