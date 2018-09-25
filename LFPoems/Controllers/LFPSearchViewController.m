//
//  LFPSearchViewController.m
//  LFPoems
//
//  Created by Xiangconnie on 15/12/12.
//  Copyright © 2015年 HUST. All rights reserved.
//

#import "LFPSearchViewController.h"
#import "LFPeomDisplayViewController.h"
#import "LFPoemAuthorInfoCell.h"
#import "LFPoemTestHelper.h"
#import "Masonry.h"
#import "LFPoem+LFStorage.h"

@interface LFPSearchViewController () <UISearchBarDelegate, UISearchDisplayDelegate>

@property (nonatomic, strong) NSArray *poems;
@property (nonatomic, strong) NSArray *filterPoems;
@property (nonatomic, strong) UISearchDisplayController *searchController;

@end

@implementation LFPSearchViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupSearchView];
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
    self.navigationItem.title = @"搜索";
}

- (void)registerCells {
//    [self.tableView registerClass:[LFPoemAuthorInfoCell class] forCellReuseIdentifier:[LFPoemAuthorInfoCell cellIdentifier]];
}

- (void)setupSearchView {
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    searchBar.placeholder = @"输入作者或者标题作为关键词搜索";
    searchBar.delegate = self;
    self.tableView.tableHeaderView = searchBar;
    
    UISearchDisplayController *controller = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    controller.searchResultsDataSource = self;
    controller.searchResultsDelegate = self;
    controller.delegate = self;
    self.searchController = controller;
}

#pragma mark - Data Load

- (void)loadTableView {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *poems = [self searchPoemsWith:@""];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.poems = poems;
            [self.tableView reloadData];
        });
    });
}

- (NSArray *)dataListForTableView:(UITableView *)tableView {
    NSArray *dataList = (self.tableView == tableView) ? self.poems : self.filterPoems;
    return dataList;
}

- (LFPoem *)poemAtRow:(NSInteger)row inSection:(NSInteger)section inTableView:(UITableView *)tableView {
    NSArray *dataList = [self dataListForTableView:tableView];
    LFPoem *poem = row < [dataList count] ? [dataList objectAtIndex:row] : nil;
    return poem;
}

- (NSArray *)searchPoemsWith:(NSString *)searchString {
    return [LFPoem lf_searchPoems:searchString];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self dataListForTableView:tableView] count];
}

#pragma mark - UITableViewDataDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LFPoem *poem = [self poemAtRow:indexPath.row inSection:indexPath.section inTableView:tableView];
    LFPoemAuthorInfoCell *cell = (LFPoemAuthorInfoCell *)[tableView dequeueReusableCellWithIdentifier:[LFPoemAuthorInfoCell cellIdentifier]];
    if (nil == cell) {
        cell = [[LFPoemAuthorInfoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:[LFPoemAuthorInfoCell cellIdentifier]];
    }
    
    [cell updateWithPoem:poem];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LFPoem *poem = [self poemAtRow:indexPath.row inSection:indexPath.section inTableView:tableView];
    LFPeomDisplayViewController *controller = [[LFPeomDisplayViewController alloc] init];
    controller.poem = poem;
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Constraints

- (void)setupConstraints {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
    }];
}

#pragma mark - 

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.filterPoems = [self searchPoemsWith:searchBar.text];
    UITableView *newTable = self.searchController.searchResultsTableView;
    [newTable reloadData];
}

#pragma mark - UISearchDisplayDelegate

- (void)searchDisplayController: (UISearchDisplayController *)controller
 willShowSearchResultsTableView: (UITableView *)searchTableView {
    searchTableView.rowHeight = self.tableView.rowHeight;
}

@end
