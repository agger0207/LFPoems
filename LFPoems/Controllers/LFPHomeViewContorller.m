//
//  LFPHomeViewContorller.m
//  LFPoems
//
//  Created by Xiangconnie on 15/12/12.
//  Copyright © 2015年 HUST. All rights reserved.
//

#import "LFPHomeViewContorller.h"
#import "LFPeomDisplayViewController.h"
#import "LFPoemTypeInfoCell.h"
#import "LFPoemAuthorInfoCell.h"
#import "LFPoem.h"
#import "LFPoet.h"
#import "Masonry.h"
#import "LFPoemTestHelper.h"
#import "LFPoem+LFStorage.h"

// TODO: 1. 数据展示优化. 比如收藏图标.
// 2. 这页需要加搜索吗？(可以暂时不加)
// 3. 最重要的是数据优化；数据要重新组建好！
// 4. 下一版本可以增加按诗歌类型搜索分类! 或者将类型加在cell里!
@interface LFPHomeViewContorller () <UITableViewDataSource, UITableViewDelegate, LFPoemActionDelegate>

@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSArray *poetList;
@property (nonatomic, strong) NSDictionary<NSString *, NSArray *> *poemDic;

@end

@implementation LFPHomeViewContorller

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.table];
    [self setupConstraints];
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
    self.navigationItem.title = @"唐诗";
}

- (void)registerCells {
//    [self.table registerClass:[LFPoemTypeInfoCell class] forCellReuseIdentifier:[LFPoemTypeInfoCell cellIdentifier]];
//    [self.table registerClass:[LFPoemAuthorInfoCell class] forCellReuseIdentifier:[LFPoemAuthorInfoCell cellIdentifier]];
}

#pragma mark - Data Load

- (void)loadTableView {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDictionary *dic = [self loadPoemsInfo];
        NSArray *poets = [[dic allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [(NSString *)obj1 compare:obj2 options:0];
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.poemDic = dic;
            self.poetList = poets;
            
            [self.table reloadData];
        });
    });
}

- (NSString *)poetNameInSection:(NSInteger)section {
    return section < [self.poetList count] ? [self.poetList objectAtIndex:section] : nil;
}

- (NSArray *)poemsOfPoet:(NSString *)poetName {
    return [self.poemDic objectForKey:poetName];
}

- (LFPoem *)poemAtRow:(NSInteger)row inSection:(NSInteger)section {
    NSArray *poems = [self poemsOfPoet:[self poetNameInSection:section]];
    return row < [poems count] ? [poems objectAtIndex:row] : nil;
}

- (NSDictionary *)loadPoemsInfo {
    return [LFPoem lf_loadPoems];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.poetList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *poems = [self poemsOfPoet:[self poetNameInSection:section]];
    return [poems count];
}

#warning GroupStyle Table HeaderView不会浮动了. TODO
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return section < [self.poetList count] ? [self.poetList objectAtIndex:section] : @"";
}

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.poetList;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return index;
}

#pragma mark - UITableViewDataDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
#warning Display different cell with different segment value.
    LFPoem *poem = [self poemAtRow:indexPath.row inSection:indexPath.section];
    LFPoemTypeInfoCell *cell = (LFPoemTypeInfoCell *)[tableView dequeueReusableCellWithIdentifier:[LFPoemTypeInfoCell cellIdentifier]];
    if (nil == cell) {
        cell = [[LFPoemTypeInfoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:[LFPoemTypeInfoCell cellIdentifier]];
    }
    [cell updateWithPoem:poem];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LFPoem *poem = [self poemAtRow:indexPath.row inSection:indexPath.section];
    LFPeomDisplayViewController *controller = [[LFPeomDisplayViewController alloc] init];
    controller.poem = poem;
    controller.index = indexPath;
    controller.poemDelegate = self;
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - LFPoemActionDelegate

- (LFPoem *)poemAtIndex:(NSIndexPath *)indexPath {
    return [self poemAtRow:indexPath.row inSection:indexPath.section];
}

- (NSIndexPath *)nextIndex:(NSIndexPath *)indexPath {
    return [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];
}

- (NSIndexPath *)prevIndex:(NSIndexPath *)indexPath {
    return [NSIndexPath indexPathForRow:indexPath.row - 1 inSection:indexPath.section];
}

#pragma mark - Constraints

- (void)setupConstraints {
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
    }];
}

#pragma makr - Getter/Setter UI Controls

- (UITableView *)table {
    if (nil == _table) {
        _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
    }
    
    return _table;
}

@end
