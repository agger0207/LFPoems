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

@property (nonatomic, strong) UILabel *label;

@end

@implementation LFPoemContentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        _label = [[UILabel alloc] initWithFrame:CGRectZero];
//        _label.font = [UIFont systemFontOfSize:18];
//        _label.textAlignment = NSTextAlignmentCenter;
//        _label.lineBreakMode = NSLineBreakByWordWrapping;
//        _label.numberOfLines = 0;
//        _label.text = @"静夜思\r\n\r\n李白\r\n\r\n床前明月光，疑是地上霜。\r\n\r\n举头望明月，低头思故乡。";

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
        _label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, stringSize.width, stringSize.height)];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.backgroundColor = [UIColor brownColor];
        _label.attributedText = attribute;
        _label.numberOfLines = 0;
        
        [self addSubview:_label];
        
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_label.superview.mas_top).with.offset(0);
//            make.left.equalTo(_label.superview.mas_left).with.offset(0);
            make.centerX.mas_equalTo(_label.superview.mas_centerX).with.offset(0);
//            make.width.mas_equalTo(stringSize.width + 20);
            make.width.mas_equalTo(stringSize.width);
            make.bottom.equalTo(_label.superview.mas_bottom).with.offset(0);
//            make.right.equalTo(_label.superview.mas_right).with.offset(0);
        }];
        
//        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(_label.superview.mas_top).with.offset(0);
//            make.left.equalTo(_label.superview.mas_left).with.offset(0);
//            make.bottom.equalTo(_label.superview.mas_bottom).with.offset(0);
//            make.right.equalTo(_label.superview.mas_right).with.offset(0);
//        }];
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
