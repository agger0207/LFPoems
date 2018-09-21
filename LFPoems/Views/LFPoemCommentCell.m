//
//  LFPoemCommentCell.m
//  LFPoems
//
//  Created by Xiangconnie on 15/12/12.
//  Copyright © 2015年 HUST. All rights reserved.
//

#import "LFPoemCommentCell.h"
#import "Masonry.h"

@interface LFPoemCommentCell()

@property (nonatomic, strong) UILabel *commentLabel;

@end

@implementation LFPoemCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _commentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _commentLabel.font = [UIFont systemFontOfSize:18];
        _commentLabel.textAlignment = NSTextAlignmentCenter;
        _commentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _commentLabel.numberOfLines = 0;
        _commentLabel.text = @"月下独酌\r\n\r\n李白\r\n\r\n花间一壶酒，独酌无相亲。举杯邀明月，对影成三人。月既不解饮，影徒随我身。暂伴月将影，行乐须及春。我歌月徘徊，我舞影零乱。醒时同交欢，醉后各分散。永结无情游，相期邈云汉。";
        [self addSubview:_commentLabel];
        
        [_commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_commentLabel.superview.mas_top).with.offset(0);
            make.left.equalTo(_commentLabel.superview.mas_left).with.offset(0);
            make.bottom.equalTo(_commentLabel.superview.mas_bottom).with.offset(0);
            make.right.equalTo(_commentLabel.superview.mas_right).with.offset(0);
            
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
    return [_commentLabel sizeThatFits:CGSizeMake(screen.bounds.size.width, MAXFLOAT)].height;
}

#pragma mark - 调整行间距等等

//NSString *aString = @"月下独酌\r\n\r\n李白\r\n\r\n花间一壶酒，独酌无相亲。举杯邀明月，对影成三人。月既不解饮，影徒随我身。暂伴月将影，行乐须及春。我歌月徘徊，我舞影零乱。醒时同交欢，醉后各分散。永结无情游，相期邈云汉。";
//CGSize titleSize = [aString sizeWithFont:[UIFont systemFontOfSize:18] constrainedToSize:CGSizeMake(320, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];


//    UIFont *font = [UIFont systemFontOfSize:18];
//
//    CGRect rect = [aString boundingRectWithSize:CGSizeMake(320, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:nil];

//    uilabel *label = [[uilable alloc]initWithFrame:frame];
//    label.numberOfLines = 0;//任意行数
//    //以下方法可以插入行间距。如果用label.text就不能插入行距，很难看。
//    NSString text = @"xxxx";
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
//
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//
//    //注意，每一行的行间距分两部分，topSpacing和bottomSpacing。
//
//    [paragraphStyle setLineSpacing:3.f];//调整行间距
//
//    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
//
//    self.attributedText = attributedString;//ios 6
//
//    CGSize size = [self sizeThatFits:CGSizeMake(label.frame.size.width, MAXFLOAT)];
//
//    CGRect frame = label.frame;
//
//    frame.size.height = size.height;
//
//    [label setFrame:frame];

@end
