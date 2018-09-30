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

+ (NSArray *)lf_loadAllPoems:(NSInteger)offset;

+ (NSArray *)lf_searchPoems:(NSString *)searchTerm offset:(NSInteger)offset;

+ (NSArray *)lf_loadRecommendedPoems;

+ (NSArray *)lf_loadRandomPoems:(BOOL)excludeDisplayed;

+ (NSArray *)lf_loadDisplayedRandomPoems;

+ (NSArray *)lf_loadFavoritePoems;

- (BOOL)lf_markAsFavorite:(BOOL)isFavorite;

- (BOOL)lf_markAsRecommended:(BOOL)isRecommended;

@end
