//
//  LFPoemInfoCell.m
//  LFPoems
//
//  Created by Xiangconnie on 15/12/12.
//  Copyright © 2015年 HUST. All rights reserved.
//

#import "LFPoemInfoCell.h"
#import "LFPoem.h"
#import "LFPoet.h"

@implementation LFPoemInfoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateWithPoem:(LFPoem *)poem {
    self.textLabel.text = poem.title;
    self.detailTextLabel.text = [NSString stringWithFormat:@"%@   %@", [LFPoem stringFromPoemType:poem.type], poem.poet.name];
}

+ (NSString *)cellIdentifier {
    return NSStringFromClass(self);
}

@end
