//
//  LFPoemTypeInfoCell.m
//  LFPoems
//
//  Created by Xiangconnie on 15/12/12.
//  Copyright © 2015年 HUST. All rights reserved.
//

#import "LFPoemTypeInfoCell.h"
#import "LFPoem.h"

@implementation LFPoemTypeInfoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateWithPoem:(LFPoem *)poem {
    self.textLabel.text = poem.title;
    self.detailTextLabel.text = [LFPoem stringFromPoemType:poem.type];
}

+ (NSString *)cellIdentifier {
    return NSStringFromClass(self);
}

@end
