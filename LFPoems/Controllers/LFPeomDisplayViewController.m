//
//  LFPeomDisplayViewController.m
//  LFPoems
//
//  Created by Xiangconnie on 15/12/12.
//  Copyright © 2015年 HUST. All rights reserved.
//

#import "LFPeomDisplayViewController.h"
#import "LFPoem.h"
#import "LFPoemControlBar.h"
#import "LFPoemContentCell.h"
#import "LFPoemCommentCell.h"
#import "LFPoemAddtionInfoCell.h"
#import "Masonry.h"
#import "LFPoemDetailBaseCell.h"

#import "LFPoemShowViewController.h"

@interface LFPeomDisplayViewController () <UITableViewDataSource, UITableViewDelegate, LFPoemControlBarDelegate>

@property (nonatomic, strong) NSArray *cellsArray;
@property (nonatomic, strong) LFPoemContentCell *contentCell;
@property (nonatomic, strong) LFPoemCommentCell *commentCell;
@property (nonatomic, strong) LFPoemAddtionInfoCell *addtionalInfoCell;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LFPoemControlBar *controlBar;

@end

@implementation LFPeomDisplayViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.controlBar];
    [self setupConstraints];
    [self loadCells];
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
    self.navigationItem.title = self.poem.title;
    [self addLeftButtonWithTitle:@"目录"];
    [self addRightButtonWithTitle:@"收藏"];
}

- (void)setupConstraints {
    [self.controlBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.height.mas_equalTo(49);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.bottom.equalTo(self.controlBar.mas_top).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
    }];
}

- (void)loadCells {
    [self refreshCells];
    self.cellsArray = @[self.contentCell, self.commentCell, self.addtionalInfoCell];
}

- (void)refreshCells {
    [self.contentCell updateWithPoem:self.poem];
    [self.commentCell updateWithPoem:self.poem];
    [self.addtionalInfoCell updateWithPoem:self.poem];
}

#pragma mark - Update Data 

- (void)updateToPoem:(LFPoem *)poem {
    // 调到下一首或者上一首
    NSLog(@"%@", poem.title);
}

#pragma mark - Action

- (IBAction)onClickRightBtn:(id)sender {
#warning 缓存的处理
    self.poem.isFavorite = YES;
    
#ifdef DEBUG
    
    LFPoemShowViewController *controller = [[LFPoemShowViewController alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
    
    
#endif
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.cellsArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    LFPoemDetailBaseCell *cell = (LFPoemDetailBaseCell *)[self.cellsArray objectAtIndex:indexPath.row];
    return [cell isKindOfClass:[LFPoemDetailBaseCell class]] ? [cell height] : 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.cellsArray objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - LFPoemControlBarDelegate

- (void)moveToNext {
    if ([self.poemDelegate respondsToSelector:@selector(nextIndex:)] &&
        [self.poemDelegate respondsToSelector:@selector(poemAtIndex:)]) {
        self.index = [self.poemDelegate nextIndex:self.index];
        //        TODO: Check whether it is the last one or first one
        self.poem = [self.poemDelegate poemAtIndex:self.index];
        [self updateToPoem:self.poem];
    }
}

- (void)moveToPrevious {
    if ([self.poemDelegate respondsToSelector:@selector(prevIndex:)] &&
        [self.poemDelegate respondsToSelector:@selector(poemAtIndex:)]) {
        self.index = [self.poemDelegate prevIndex:self.index];
        //        TODO: Check whether it is the last one or first one
        self.poem = [self.poemDelegate poemAtIndex:self.index];
        [self updateToPoem:self.poem];
    }
}

- (void)play {
    //    TODO: Play the vedio
}

- (void)record {
    // TODO: Record the vedio
}

#pragma mark - Getter/Setter UI Controls

- (UITableView *)tableView {
    if (nil == _tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _tableView;
}

- (LFPoemControlBar *)controlBar {
    if (nil == _controlBar) {
        _controlBar = [[LFPoemControlBar alloc] initWithFrame:CGRectZero];
        _controlBar.delegate = self;
#ifdef DEBUG
        _controlBar.backgroundColor = [UIColor purpleColor];
#endif
    }
    
    return _controlBar;
}

- (LFPoemContentCell *)contentCell {
    if (nil == _contentCell) {
        _contentCell = [[LFPoemContentCell alloc] init];
    }
    
    return _contentCell;
}

- (LFPoemCommentCell *)commentCell {
    if (nil == _commentCell) {
        _commentCell = [[LFPoemCommentCell alloc] init];
    }
    
    return _commentCell;
}

- (LFPoemAddtionInfoCell *)addtionalInfoCell {
    if (nil == _addtionalInfoCell) {
        _addtionalInfoCell = [[LFPoemAddtionInfoCell alloc] init];
    }
    
    return _addtionalInfoCell;
}

@end
