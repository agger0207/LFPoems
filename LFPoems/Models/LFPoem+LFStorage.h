//
//  LFPoem+LFStorage.h
//  LFPoems
//
//  Created by Xiangconnie on 2018/9/22.
//  Copyright © 2018年 HUST. All rights reserved.
//

#import "LFPoem.h"

@interface LFPoem (LFStorage)

+ (NSDictionary<NSString *, NSArray *> *)lf_loadPoems;

+ (NSArray *)lf_loadAllPoems;

+ (NSArray *)lf_searchPoems:(NSString *)searchTerm;

@end
