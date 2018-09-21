//
//  LFPoemDetailViewController.m
//  LFPoems
//
//  Created by Xiangconnie on 16/3/6.
//  Copyright © 2016年 HUST. All rights reserved.
//

#import "LFPoemDetailViewController.h"
#import "LFPoemContentCell.h"
#import "LFPoemCommentCell.h"
#import "LFPoemAddtionInfoCell.h"
#import "LFPoemControlBar.h"
#import "Masonry.h"
#import "LFPoem.h"

@interface LFPoemDetailViewController () <UITableViewDataSource, UITableViewDelegate, LFPoemControlBarDelegate>

@property (nonatomic, strong) NSArray *cellsArray;
@property (nonatomic, strong) LFPoemContentCell *contentCell;
@property (nonatomic, strong) LFPoemCommentCell *commentCell;
@property (nonatomic, strong) LFPoemAddtionInfoCell *addtionalInfoCell;
@property (nonatomic, strong) UITableView *tableView;
//@property (nonatomic, strong) LFPoemControlBar *controlBar;

@end

@implementation LFPoemDetailViewController

#pragma mark - Factory Methods

+ (instancetype)controllerWithIndex:(NSInteger)index {
    LFPoemDetailViewController *vc = [[LFPoemDetailViewController alloc] init];
    return vc;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.tableView.allowsSelection = FALSE;
//    [self.view addSubview:self.controlBar];
//
//    self.tableView.estimatedRowHeight = 213;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
//
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

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    NSLog(@"%@", self.view);
}

- (void)setupConstraints {
//    [self.controlBar mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view.mas_left).with.offset(0);
//        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
//        make.right.equalTo(self.view.mas_right).with.offset(0);
//        make.height.mas_equalTo(49);
//    }];
    
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view.mas_top).with.offset(64);
//        make.left.equalTo(self.view.mas_left).with.offset(0);
//        make.bottom.equalTo(self.controlBar.mas_top).with.offset(0);
//        make.right.equalTo(self.view.mas_right).with.offset(0);
//    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(64);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
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
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.cellsArray count];
}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    LFPoemDetailBaseCell *cell = (LFPoemDetailBaseCell *)[self.cellsArray objectAtIndex:indexPath.row];
//    return [cell isKindOfClass:[LFPoemDetailBaseCell class]] ? [cell height] : 44;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.cellsArray objectAtIndex:indexPath.row];
    return cell;
}

#pragma makr - Getter/Setter UI Controls

- (UITableView *)tableView {
    if (nil == _tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.allowsSelection = FALSE;
        _tableView.estimatedRowHeight = 213;
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    
    return _tableView;
}

//- (LFPoemControlBar *)controlBar {
//    if (nil == _controlBar) {
//        _controlBar = [[LFPoemControlBar alloc] initWithFrame:CGRectZero];
//        _controlBar.delegate = self;
//#ifdef DEBUG
//        _controlBar.backgroundColor = [UIColor purpleColor];
//#endif
//    }
//    
//    return _controlBar;
//}

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
