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

@interface LFPFavoriteViewController ()

@property (nonatomic, strong) NSArray *poems;

@end

@implementation LFPFavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self registerCells];
    [self loadTableView];
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
            [self.tableView reloadData];
        });
    });
}

- (LFPoem *)poemAtRow:(NSInteger)row inSection:(NSInteger)section {
    LFPoem *poem = row < [self.poems count] ? [self.poems objectAtIndex:row] : nil;
    return poem;
}

- (NSArray *)favoritePoems {
#ifdef DEBUG
    
    return [LFPoemTestHelper favoritePoemsForTest];
    
#endif
    
    NSMutableArray *array = [NSMutableArray array];
#warning TODO
    return array;
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
    
}

@end
