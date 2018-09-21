//
//  LFPoemAddtionInfoCell.m
//  LFPoems
//
//  Created by Xiangconnie on 15/12/12.
//  Copyright © 2015年 HUST. All rights reserved.
//

#import "LFPoemAddtionInfoCell.h"
#import "Masonry.h"

@interface LFPoemAddtionInfoCell()

@property (nonatomic, strong) UILabel *label;

@end

@implementation LFPoemAddtionInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _label = [[UILabel alloc] initWithFrame:CGRectZero];
        _label.font = [UIFont systemFontOfSize:18];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.lineBreakMode = NSLineBreakByWordWrapping;
        _label.numberOfLines = 0;
        _label.text = @"月下独酌\r\n李白\r\n花间一壶酒，独酌无相亲。举杯邀明月，对影成三人。月既不解饮，影徒随我身。暂伴月将影，行乐须及春。我歌月徘徊，我舞影零乱。醒时同交欢，醉后各分散。永结无情游，相期邈云汉。";
        [self addSubview:_label];
        
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_label.superview.mas_top).with.offset(10);
            make.left.equalTo(_label.superview.mas_left).with.offset(0);
            make.bottom.equalTo(_label.superview.mas_bottom).with.offset(0);
            make.right.equalTo(_label.superview.mas_right).with.offset(0);
            
        }];
    }
    
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (void)updateWithPoem:(LFPoem *)poem {
    
}

- (CGFloat)height {
    // 根据Label的内容来计算高度.
    UIScreen *screen = [UIScreen mainScreen];
    return [_label sizeThatFits:CGSizeMake(screen.bounds.size.width, MAXFLOAT)].height + 10;
}

@end
