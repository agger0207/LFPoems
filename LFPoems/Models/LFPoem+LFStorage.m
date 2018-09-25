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

    return model;
}

+ (NSDictionary<NSString *, NSArray *> *)lf_loadPoems {
    NSMutableDictionary<NSString *, NSMutableArray *> *poemsDic = [[NSMutableDictionary alloc] init];
    // 用李白的诗来做测试
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE author = '李白' OR author = '杜甫'", kTablePoems];
    [LF_POEMS_DB executeQuery:sql result:^(FMResultSet *rs, BOOL *end) {
        LFPoem *model = [self instanceFromCursor:rs];
        if (nil != model && nil != model.poet) {
            NSMutableArray *poems = poemsDic[model.poet.name];
            if (nil == poems) {
                poems = [[NSMutableArray alloc] init];
                poemsDic[model.poet.name] = poems;
            }
            [poems addObject:model];
        }
    }];
    
    return poemsDic;
}

+ (NSArray *)lf_loadAllPoems {
    NSMutableArray *poems = [[NSMutableArray alloc] init];
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@", kTablePoems];
    [LF_POEMS_DB executeQuery:sql result:^(FMResultSet *rs, BOOL *end) {
        LFPoem *model = [self instanceFromCursor:rs];
        [poems addObject:model];
    }];
    
    return poems;
}

+ (NSArray *)lf_searchPoems:(NSString *)searchTerm {
    if (searchTerm.length == 0) {
        return [self lf_loadAllPoems];
    }
    
    NSMutableArray *poems = [[NSMutableArray alloc] init];
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE author = '%@' OR title LIKE '%@%@%@'", kTablePoems, searchTerm, @"%", searchTerm, @"%"];
    NSLog(@"%@", sql);
    [LF_POEMS_DB executeQuery:sql result:^(FMResultSet *rs, BOOL *end) {
        LFPoem *model = [self instanceFromCursor:rs];
        [poems addObject:model];
    }];
    
    return poems;
}

#pragma mark - Private Methods

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
