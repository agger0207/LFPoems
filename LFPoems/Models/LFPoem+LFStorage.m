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
    model.title = [result stringForColumn:kColumnModelTitle];
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

@end
