//
//  LFPSettingViewController.m
//  LFPoems
//
//  Created by Xiangconnie on 15/12/12.
//  Copyright © 2015年 HUST. All rights reserved.
//

#import "LFPSettingViewController.h"
#import "RETableViewManager.h"
#import "Masonry.h"

@interface LFPSettingViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) RETableViewManager *manager;
@property (nonatomic, assign) BOOL enableNotification;

@end

@implementation LFPSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    self.navigationItem.title = @"设置";
}

- (void)loadTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    
    [self setupTableView];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
    }];
}

- (void)setupTableView {
    // Create manager
    self.manager = [[RETableViewManager alloc] initWithTableView:self.tableView];
    
    // Add sections and items
    [self.manager addSection:[self basicSection]];
    [self.manager addSection:[self addtionalSection]];
}

- (RETableViewSection *)basicSection {
    RETableViewSection *section = [RETableViewSection section];
    // 只有设置一个极小的值才可以去掉Header.
    section.headerHeight = 0.1;
    __weak LFPSettingViewController *weakSelf = self;
#warning 后续考虑展示什么内容
    [section addItem:[RETableViewItem itemWithTitle:@"操作说明" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
        [item deselectRowAnimated:YES];
        //        [weakSelf.navigationController pushViewController:[[ControlsViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
    }]];
    
    [section addItem:[REBoolItem itemWithTitle:@"消息提醒" value:self.enableNotification switchValueChangeHandler:^(REBoolItem *item) {
        weakSelf.enableNotification = item.value;
    }]];
    
    RESegmentedItem *viewItem = [RESegmentedItem itemWithTitle:@"视图模式" segmentedControlTitles:@[@"正常", @"夜间"] value:0 switchValueChangeHandler:^(RESegmentedItem *item) {
#warning TODO 切换模式
    }];
    viewItem.tintColor = [UIColor blueColor];
    [section addItem:viewItem];
    
    return section;
}

- (RETableViewSection *)addtionalSection {
    RETableViewSection *section = [RETableViewSection section];
    section.headerTitle = @"技术支持";
    section.headerHeight = 0;

#warning 后续考虑展示什么内容. 数据组织可以进一步优化.
    [section addItem:[RETableViewItem itemWithTitle:@"问题反馈" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
        [item deselectRowAnimated:YES];
        //        [weakSelf.navigationController pushViewController:[[ControlsViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
    }]];
    
    [section addItem:[RETableViewItem itemWithTitle:@"给我好评" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
        [item deselectRowAnimated:YES];
        //        [weakSelf.navigationController pushViewController:[[ListViewController alloc] initWithStyle:UITableViewStylePlain] animated:YES];
    }]];
    
    [section addItem:[RETableViewItem itemWithTitle:@"版本信息" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
        [item deselectRowAnimated:YES];
        //        [weakSelf.navigationController pushViewController:[[EditingViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
    }]];
    
    [section addItem:[RETableViewItem itemWithTitle:@"关于我们" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
        [item deselectRowAnimated:YES];
        //        [weakSelf.navigationController pushViewController:[[RetractableViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
    }]];
    
    return section;
}

@end
