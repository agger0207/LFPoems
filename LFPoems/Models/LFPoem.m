//
//  LFPoem.m
//  LFPoems
//
//  Created by Xiangconnie on 15/12/12.
//  Copyright © 2015年 HUST. All rights reserved.
//

#import "LFPoem.h"

@implementation LFPoem

#pragma mark - Helper Methods

+ (NSString *)stringFromPoemType:(LFPoemType)type {
    NSString *typeDescription;
    switch (type) {
        case LFPoemTypeFiveWordMetrical:
            typeDescription = @"五言律诗";
            break;
            
        default:
            typeDescription = @"";
            break;
    }
    
    return typeDescription;
}

@end
