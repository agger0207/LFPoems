//
//  LFPFavoriteViewController.m
//  LFPoems
//
//  Created by Xiangconnie on 15/12/12.
//  Copyright © 2015年 HUST. All rights reserved.
//

#import "LFPFavoriteViewController.h"
#import "LFPeomDisplayViewController.h"
#import "LFPoemInfoCell.h"
#import "LFPoemTestHelper.h"
#import "LFPoet.h"
#import "LFPoem.h"
#import "LFPoem+LFStorage.h"
#import "LFConstants.h"

// TODO: 1. 展示空Table Review的提示.
// 2. 空Table Review的时候不要有分割线

@interface LFPFavoriteViewController () <LFPoemActionDelegate>

@property (nonatomic, strong) NSArray *poems;
@property (nonatomic, assign) BOOL isDataChanged;

@end

@implementation LFPFavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.tintColor = [UIColor redColor];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    [self.refreshControl addTarget:self action:@selector(loadNewData) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
    [self registerCells];
    [self loadTableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onDataChanged:) name:kLFFavoriteChanged object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear in favorite");
    if (self.isDataChanged) {
        self.isDataChanged = NO;
        [self loadTableView];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

#pragma mark - Init UI.

- (void)initNavigationItem {
    self.navigationItem.title = @"收藏";
}

- (void)registerCells {
    // TODO: registerClass后如何使用不同Style的Cell ?
//    [self.tableView registerClass:[LFPoemInfoCell class] forCellReuseIdentifier:[LFPoemInfoCell cellIdentifier]];
}

#pragma mark - Data Load

- (void)loadTableView {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *poems = [self favoritePoems];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.poems = poems;
            self.isDataChanged = NO;
            [self.tableView reloadData];
        });
    });
}

- (LFPoem *)poemAtRow:(NSInteger)row inSection:(NSInteger)section {
    LFPoem *poem = row < [self.poems count] ? [self.poems objectAtIndex:row] : nil;
    return poem;
}

- (NSArray *)favoritePoems {
    return [LFPoem lf_loadFavoritePoems];
}

#pragma mark - Refresh Data

- (void)loadNewData {
    if (self.refreshControl.refreshing) {
        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"加载中..."];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSArray *poems = [self favoritePoems];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.poems = poems;
                self.isDataChanged = NO;
                [self.refreshControl endRefreshing];
                [self.tableView reloadData];
            });
        });
    }
}

- (void)onDataChanged:(id)sender {
    self.isDataChanged = YES;
}

#pragma mark - UITableViewDataSource
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 60;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.poems count];
}

#pragma mark - UITableViewDataDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LFPoem *poem = [self poemAtRow:indexPath.row inSection:indexPath.section];
    LFPoemInfoCell *cell = (LFPoemInfoCell *)[tableView dequeueReusableCellWithIdentifier:[LFPoemInfoCell cellIdentifier]];
    if (nil == cell) {
        cell = [[LFPoemInfoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:[LFPoemInfoCell cellIdentifier]];
    }
    [cell updateWithPoem:poem];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LFPoem *poem = [self poemAtRow:indexPath.row inSection:indexPath.section];
    LFPeomDisplayViewController *controller = [[LFPeomDisplayViewController alloc] init];
    controller.poem = poem;
    controller.poemDelegate = self;
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Constraints
//
//- (void)setupConstraints {
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view.mas_top).with.offset(0);
//        make.left.equalTo(self.view.mas_left).with.offset(0);
//        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
//        make.right.equalTo(self.view.mas_right).with.offset(0);
//    }];
//}

#pragma mark - Actions

- (IBAction)addFavorite:(id)sender {
    // 这个功能下一版本再加
}

#pragma mark - LFPoemActionDelegate

- (LFPoem *)poemAtIndex:(NSIndexPath *)index {
    return [self poemAtRow:index.row inSection:index.section];
}

- (NSIndexPath *)nextIndex:(NSIndexPath *)index {
    return [NSIndexPath indexPathForRow:index.row + 1 inSection:0];
}

- (NSIndexPath *)prevIndex:(NSIndexPath *)index {
    return [NSIndexPath indexPathForRow:index.row - 1 inSection:0];
}

- (BOOL)isLastIndex:(NSIndexPath *)index {
    return index.section == 0 && index.row + 1 == [self.poems count];
}

- (BOOL)isFirstIndex:(NSIndexPath *)index {
    return index.section == 0 && index.row == 0;
}

@end
