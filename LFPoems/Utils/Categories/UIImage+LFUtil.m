//
//  UIImage+LFUtil.m
//  PhotoFun
//
//  Created by HUST on 15/7/1.
//  Copyright (c) 2015年 HUST. All rights reserved.
//

#import "UIImage+LFUtil.h"

@implementation UIImage (LFUtil)

- (UIImage *)getStretchableImage {
    UIImage *stretchableImage  = [self stretchableImageWithLeftCapWidth:floorf(self.size.width/2) topCapHeight:floorf(self.size.height/2)];
    return stretchableImage;
}

@end
