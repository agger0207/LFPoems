//
//  LFPoemContentCell.m
//  LFPoems
//
//  Created by Xiangconnie on 15/12/12.
//  Copyright © 2015年 HUST. All rights reserved.
//

#import "LFPoemContentCell.h"
#import "Masonry.h"

@interface LFPoemContentCell ()

@property (nonatomic, strong) UILabel *longestContentLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *poetLabel;
@property (nonatomic, strong) NSMutableArray<UILabel *> *contentLabels;

@end

@implementation LFPoemContentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _contentLabels = [[NSMutableArray alloc] init];
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _titleLabel.numberOfLines = 0;
        _titleLabel.text = @"静夜思";
        
        _poetLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _poetLabel.font = [UIFont systemFontOfSize:14];
        _poetLabel.textAlignment = NSTextAlignmentCenter;
        _poetLabel.textColor = [UIColor grayColor];
        _poetLabel.text = @"李白";
        
//        NSArray *paragraphs = @[@"床前明月光，疑是地上霜。", @"举头望明月，低头思故乡。"];
//        月下独酌\r\n\r\n李白\r\n\r\n花间一壶酒，独酌无相亲。举杯邀明月，对影成三人。月既不解饮，影徒随我身。暂伴月将影，行乐须及春。我歌月徘徊，我舞影零乱。醒时同交欢，醉后各分散。永结无情游，相期邈云汉。
        NSArray *paragraphs = @[
                                @"这是",
                                @"明月，对影成三人。",
                                @"月既不解饮，影徒随我身。",
                                @"暂伴月将影，行乐须及春。",
                                @"我歌月徘徊，我舞影零乱。",
                                @"醒时同交欢，醉后各分散。",
                                @"永结无情游，相期邈云汉。"
                                ];
        
        NSInteger maxContentLen = 0;
        for (NSString *content in paragraphs) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.font = [UIFont systemFontOfSize:15];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = content;
            if (content.length > maxContentLen) {
                _longestContentLabel = label;
            }
            [_contentLabels addObject:label];
        }
        
        [self.contentView addSubview:_titleLabel];
        [self.contentView addSubview:_poetLabel];
        for (UILabel *label in _contentLabels) {
            [self.contentView addSubview:label];
        }
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(10);
            make.height.mas_equalTo(32);
            make.centerX.mas_equalTo(self.contentView.mas_centerX).with.offset(0);
        }];
        [_poetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLabel.mas_bottom).with.offset(0);
            make.height.mas_equalTo(30);
            make.centerX.mas_equalTo(self.contentView.mas_centerX).with.offset(0);
        }];
        [_longestContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerX.mas_equalTo(self.contentView.mas_centerX).with.offset(0);
        }];
        UILabel *previousLabel = _poetLabel;
        for (UILabel *label in _contentLabels) {
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(previousLabel.mas_bottom).with.offset(0);
                make.height.mas_equalTo(24);
                if (label != _longestContentLabel) {
                    make.left.mas_equalTo(_longestContentLabel.mas_left).with.offset(0);
                }
            }];
            previousLabel = label;
        }
        
        [previousLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-10);
        }];
    }
    
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)updateWithPoem:(LFPoem *)poem {
    
}

@end
