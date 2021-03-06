//
//  LFPoemContentCell.m
//  LFPoems
//
//  Created by Xiangconnie on 15/12/12.
//  Copyright © 2015年 HUST. All rights reserved.
//

#import "LFPoemContentCell.h"
#import "Masonry.h"
#import "LFPoem.h"
#import "LFPoet.h"

NSInteger const maxLengthOneLine = 18;

@interface LFPoemContentCell ()

@property (nonatomic, strong) UILabel *longestContentLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *poetLabel;
@property (nonatomic, strong) NSMutableArray<UILabel *> *contentLabels;
@property (nonatomic, strong) NSArray<NSString *> *paragraphs;

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
        
        [self.contentView addSubview:_titleLabel];
        [self.contentView addSubview:_poetLabel];
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
        
        NSArray *paragraphs = @[
                                @"这是",
                                @"明月，对影成三人。",
                                @"月既不解饮，影徒随我身。",
                                @"暂伴月将影，行乐须及春。",
                                @"我歌月徘徊，我舞影零乱。",
                                @"醒时同交欢，醉后各分散。",
                                @"永结无情游，相期邈云汉。"
                                ];
        [self showPoemContent:paragraphs];
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

#pragma mark - Show Poem

- (void)showPoemContent:(NSArray<NSString *> *)paragraphs {
    self.longestContentLabel = NULL;
    for (UILabel *label in self.contentLabels) {
        [label removeFromSuperview];
    }
    
    [self.contentLabels removeAllObjects];
    
    NSInteger maxContentLen = 0;
    for (NSString *content in paragraphs) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = content;
        if (content.length > maxContentLen && content.length < maxLengthOneLine) {
            maxContentLen = content.length;
            self.longestContentLabel = label;
        }
        [self.contentLabels addObject:label];
    }
    for (UILabel *label in self.contentLabels) {
        [self.contentView addSubview:label];
    }
    [self.longestContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX).with.offset(0);
    }];
    UILabel *previousLabel = self.poetLabel;
    for (UILabel *label in self.contentLabels) {
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(previousLabel.mas_bottom).with.offset(0);
            make.height.mas_equalTo(24);
            if (label != self.longestContentLabel) {
                make.left.mas_equalTo(self.longestContentLabel.mas_left).with.offset(0);
            }
        }];
        previousLabel = label;
    }
    
    [previousLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-10);
    }];
}

- (void)updateWithPoem:(LFPoem *)poem {
    self.titleLabel.text = poem.title;
    self.poetLabel.text = poem.poet.name;
    NSLog(@"content: %@", poem.content);
    NSArray *paragraphs = [poem.content componentsSeparatedByString: @"\n"];
    NSMutableArray *normalizedParagraphs = [[NSMutableArray alloc] init];
    NSLog(@"paragraphs: %lu", paragraphs.count);
    for (NSString *paragraph in paragraphs) {
        NSLog(@"paragraph: %@", paragraph);
        if (paragraph.length >= maxLengthOneLine) {
            NSRange range;
            // TODO: 对于精选类，需要重新整理段落; 或者根据长度来划分
            if ([paragraph containsString:@"？"]) {
                // TODO: 丈夫誓许国，愤惋复何有？功名图麒麟，战骨当速朽。应该分为两句而不是四句
                range = [paragraph rangeOfString:@"？" options:NSBackwardsSearch];
            } else if ([paragraph containsString:@"！"]) {
                // TODO: 丈夫誓许国，愤惋复何有？功名图麒麟，战骨当速朽。应该分为两句而不是四句
                range = [paragraph rangeOfString:@"！" options:NSBackwardsSearch];
            } else if ([paragraph containsString:@"，"]) {
                // TODO: 五花马，千金裘，呼儿将出换美酒，与尔同销万古愁。应该分为两句而不是四句
                range = [paragraph rangeOfString:@"，" options:NSBackwardsSearch];
            }
            
            if (range.location > 0 && paragraph.length > range.location + 1) {
                [normalizedParagraphs addObject:[paragraph substringToIndex:range.location + 1]];
                [normalizedParagraphs addObject:[paragraph substringFromIndex:range.location + 1]];
            }
        } else {
            [normalizedParagraphs addObject:paragraph];
        }
    }
    
    self.paragraphs = normalizedParagraphs;
    [self showPoemContent:self.paragraphs];
}

@end
