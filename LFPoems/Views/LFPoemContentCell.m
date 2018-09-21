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

@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *poetLabel;

@end

@implementation LFPoemContentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
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
        
        NSString *content = @"床前明月光，疑是地上霜。举头望明月，低头思故乡。";
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
//        paragraph.lineBreakMode = NSLineBreakByCharWrapping;
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
//        paragraph.firstLineHeadIndent = 20.0f;//首行缩进
//        paragraph.headIndent = 20.0f;
//        paragraph.tailIndent = 20.0f;
        paragraph.lineSpacing = 10;
        UIFont *font = [UIFont systemFontOfSize:15];
        UIColor *color = [UIColor yellowColor];
        NSDictionary *dict = @{NSFontAttributeName: font,
                               NSForegroundColorAttributeName: color,
                               NSParagraphStyleAttributeName: paragraph};
        NSString *lineContent = @"床前明月光。";
        CGSize stringSize = [lineContent boundingRectWithSize:CGSizeMake(200, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
        NSLog(@"stringSize is %f", stringSize.width);
        NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:content attributes:dict];
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, stringSize.width, stringSize.height)];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.backgroundColor = [UIColor brownColor];
        _contentLabel.attributedText = attribute;
        _contentLabel.numberOfLines = 0;
        
        [self addSubview:_titleLabel];
        [self addSubview:_contentLabel];
        [self addSubview:_poetLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLabel.superview.mas_top).with.offset(0);
            make.height.mas_equalTo(32);
            make.centerX.mas_equalTo(_titleLabel.superview.mas_centerX).with.offset(0);
        }];
        [_poetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLabel.mas_bottom).with.offset(0);
            make.height.mas_equalTo(20);
            make.centerX.mas_equalTo(_poetLabel.superview.mas_centerX).with.offset(0);
        }];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_poetLabel.mas_bottom).with.offset(6);
            make.bottom.equalTo(_contentLabel.superview.mas_bottom).with.offset(0);
            make.centerX.mas_equalTo(_contentLabel.superview.mas_centerX).with.offset(0);
            make.width.mas_equalTo(stringSize.width);
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

- (CGFloat)height {
    return 168;
}


@end
