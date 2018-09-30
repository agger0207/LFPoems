//
//  LFPoem+LFStorage.m
//  LFPoems
//
//  Created by Xiangconnie on 2018/9/22.
//  Copyright © 2018年 HUST. All rights reserved.
//

#import "LFPoem+LFStorage.h"
#import "LFPoemsDatabaseHelper.h"
#import "LFPoet.h"

NSString * const kTablePoems = @"poem";
NSString * const kColumnModelID = @"id";
NSString * const kColumnModelTitle = @"title";
NSString * const kColumnModelAuthor = @"author";
NSString * const kColumnModelContent = @"txt";
NSString * const kColumnModelIsFavorite = @"favorite";
NSString * const kColumnModelIsRecommended = @"recommended";
NSString * const kColumnModelType = @"type";
NSString * const kColumeModelTags = @"tags";
// 代码自动格式化:  快捷键：. ctrl+ i

@implementation LFPoem (LFStorage)

+ (instancetype)instanceFromCursor:(FMResultSet *)result {
    if (nil == result) {
        return nil;
    }
    
    // TODO: Organize the data better.
    LFPoem *model = [[LFPoem alloc] init];
    model.poemId = [[result stringForColumn:kColumnModelID] integerValue];
    NSString *title = [result stringForColumn:kColumnModelTitle];
    NSArray *titleArray = [title componentsSeparatedByString:@" "];
    if (titleArray.count == 2) {
        model.title = [self isNumber:titleArray[1]] ? title : titleArray[1];
    } else {
        model.title = title;
    }
    NSString *authorName = [result stringForColumn:kColumnModelAuthor];
    NSString *content = [result stringForColumn:kColumnModelContent];
    LFPoet *poet = [[LFPoet alloc] init];
    poet.name = authorName;
    model.poet = poet;
    model.content = content;
    model.isFavorite = [result boolForColumn:kColumnModelIsFavorite];
    model.isRecommended = [result boolForColumn:kColumnModelIsRecommended];
    model.type = [result intForColumn:kColumnModelType];
    
    return model;
}

// 首页. 展示精选诗
+ (NSDictionary<NSString *, NSArray *> *)lf_loadPoems {
    NSString *sql =[NSString stringWithFormat:@"SELECT * FROM %@ WHERE recommended = 1", kTablePoems];
    return [self loadPoemsDicWithSql:sql];
}

// 全部诗.
+ (NSArray *)lf_loadAllPoems {
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@", kTablePoems];
    return [self loadPoemsWithSql:sql];
}

// 搜索. 用于全唐诗页面.
+ (NSArray *)lf_searchPoems:(NSString *)searchTerm {
    if (searchTerm.length == 0) {
        return [self lf_loadAllPoems];
    }
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE author = '%@' OR title LIKE '%@%@%@'", kTablePoems, searchTerm, @"%", searchTerm, @"%"];
    return [self loadPoemsWithSql:sql];
}

// 将来用于首页精选诗歌
+ (NSArray *)lf_loadRecommendedPoems {
    NSString *sql =[NSString stringWithFormat:@"SELECT * FROM %@ WHERE recommended = 1", kTablePoems];
    return [self loadPoemsWithSql:sql];
}

// 每日随机推荐的诗. 一定是从精选中挑一首.
+ (NSArray *)lf_loadRandomPoems {
    return [self lf_loadRecommendedPoems];
}

// 收藏的诗
+ (NSArray *)lf_loadFavoritePoems {
    NSString *sql =[NSString stringWithFormat:@"SELECT * FROM %@ WHERE favorite = 1", kTablePoems];
    return [self loadPoemsWithSql:sql];
}

- (BOOL)lf_markAsFavorite:(BOOL)isFavorite {
    if (!(self.isFavorite ^ isFavorite)) {
        NSLog(@"Unnecessary to update database");
        return YES;
    }
    
    NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET favorite = %@ WHERE id = %@", kTablePoems, isFavorite ? @"1": @"0", @(self.poemId)];
    [LF_POEMS_DB executeUpdate:sql];
    self.isFavorite = isFavorite;
    return YES;
}

// 这个功能不开放给用户. 用于我自己来设置数据库用.
- (BOOL)lf_markAsRecommended:(BOOL)isRecommended {
    if (self.isRecommended ^ isRecommended) {
        NSLog(@"Unnecessary to update database");
        return YES;
    }
    
    NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET recommended = %@ WHERE id = %@", kTablePoems, isRecommended ? @"1": @"0", @(self.poemId)];
    [LF_POEMS_DB executeUpdate:sql];
    self.isRecommended = isRecommended;
    return NO;
}

#pragma mark - Private Methods

+ (NSDictionary<NSString *, NSArray *> *)loadPoemsDicWithSql:(NSString *)sql {
    NSMutableDictionary<NSString *, NSMutableArray *> *poemsDic = [[NSMutableDictionary alloc] init];
    [LF_POEMS_DB executeQuery:sql result:^(FMResultSet *rs, BOOL *end) {
        LFPoem *model = [self instanceFromCursor:rs];
        if (nil != model && nil != model.poet) {
            NSString *poetKey = [self isFamousPoet:model.poet.name] ? model.poet.name : @"其他";
            NSMutableArray *poems = poemsDic[poetKey];
            if (nil == poems) {
                poems = [[NSMutableArray alloc] init];
                poemsDic[poetKey] = poems;
            }
            [poems addObject:model];
        }
    }];
    
    return poemsDic;
}

+ (NSArray *)loadPoemsWithSql:(NSString *)sql {
    NSMutableArray *poems = [[NSMutableArray alloc] init];
    [LF_POEMS_DB executeQuery:sql result:^(FMResultSet *rs, BOOL *end) {
        LFPoem *model = [self instanceFromCursor:rs];
        [poems addObject:model];
    }];
    
    return poems;
}

+ (BOOL)isNumber:(NSString *)title {
    if (title.length <= 1) {
        return TRUE;
    }
    
    static NSArray *chineseNumbers = nil;
    if (chineseNumbers == nil) {
        chineseNumbers = @[@"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十", @"二十一", @"二十二", @"二十三", @"二十四", @"二十五", @"二十六", @"二十七", @"二十八", @"二十九", @"三十", @"三十一", @"三十二", @"三十三", @"三十四", @"三十五", @"三十六", @"三十七", @"三十八", @"三十九", @"四十", @"四十一", @"四十二", @"四十三", @"四十四", @"四十五", @"四十六", @"四十七", @"四十八", @"四十九", @"五十"];
    }
    
    return [chineseNumbers containsObject:title];
}

@end
