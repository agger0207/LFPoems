//
//  LFPRandomViewController.m
//  LFPoems
//
//  Created by Xiangconnie on 15/12/12.
//  Copyright © 2015年 HUST. All rights reserved.
//

#import "LFPRandomViewController.h"
#import "Masonry.h"
#import "LFPoem+LFStorage.h"
#import "LFPoem.h"
#import "LFPoemContentCell.h"
#import "LFPoemTestHelper.h"

// 重点：1. 数据整理；2. 推荐功能。 3. Tags
@interface LFPRandomViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *candidatePoems;

@property (nonatomic, strong) NSArray *cellsArray;
@property (nonatomic, strong) LFPoemContentCell *contentCell;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LFPoem *currentPoem;

@end

@implementation LFPRandomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.currentPoem = [LFPoemTestHelper poemForTest];
    [self.view addSubview:self.tableView];
    [self setupConstraints];
    [self loadCells];
    [self loadData];
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
    self.navigationItem.title = @"今日推荐";
    [self addLeftButtonWithTitle:@"换一首"];
    [self addRightButtonWithTitle:@"收藏"];
}


- (void)setupConstraints {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
    }];
}

- (void)loadCells {
    [self refreshCells];
    self.cellsArray = @[self.contentCell];
}

- (void)refreshCells {
    [self.contentCell updateWithPoem:self.currentPoem];
}

- (void)updateToPoem:(LFPoem *)poem {
    [self.contentCell updateWithPoem:poem];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.cellsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.cellsArray objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - Getter/Setter UI Controls

- (UITableView *)tableView {
    if (nil == _tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 200;
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    
    return _tableView;
}

- (LFPoemContentCell *)contentCell {
    if (nil == _contentCell) {
        _contentCell = [[LFPoemContentCell alloc] init];
    }
    
    return _contentCell;
}

#pragma mark - Override Subclass

- (void)addLeftButtonWithTitle:(NSString *)title {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(onClickLeftButton:)];
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blueColor]} forState:UIControlStateNormal];
}

- (void)addRightButtonWithTitle:(NSString *)title {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(onClickRightBtn:)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blueColor]} forState:UIControlStateNormal];
}

#pragma mark - Actions

- (IBAction)onClickLeftButton:(id)sender {
    self.currentPoem = [self randomSelectPoem];
}

- (IBAction)onClickRightBtn:(id)sender {
    BOOL wasFavorite = self.currentPoem.isFavorite;
    [self.currentPoem lf_markAsFavorite:!wasFavorite];
    self.navigationItem.rightBarButtonItem.title = self.currentPoem.isFavorite ? @"取消收藏" : @"收藏";
}

#pragma mark - Load data

- (void)loadData {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *poems = [self loadPoemsInfo];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.candidatePoems = poems;
            NSLog(@"Poem is Load: %@", poems);
            self.currentPoem = [self randomSelectPoem];
            self.currentPoem.wasDisplayed = YES;
            [self updateToPoem:self.currentPoem];
        });
    });
}

// TODO: 在About页面中展示推荐过的诗. 这里只有没有展示过的诗
- (NSArray *)loadPoemsInfo {
    return [LFPoem lf_loadRandomPoems:TRUE];
}

- (LFPoem *)randomSelectPoem {
    NSInteger count = [self.candidatePoems count];
    if (count == 0) {
        return nil;
    }
    NSInteger index = arc4random() % count;
    LFPoem *poem =self.candidatePoems[index];
    NSInteger retry = 0;
    while (retry < 5 && (poem == nil || poem.wasDisplayed)) {
        retry ++;
        index = arc4random() % count;
        poem = self.candidatePoems[index];
    }
    
    return poem;
}

@end
