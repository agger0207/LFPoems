//
//  LFPoemsDatabaseHelper.m
//  LFPoems
//
//  Created by Wangliping on 15/12/11.
//  Copyright © 2015年 HUST. All rights reserved.
//

#import "LFPoemsDatabaseHelper.h"
#import "FMDatabaseQueue.h"
#import "LFCommonUtility.h"

NSString * const LFPoemsDBName = @"LFPoems.db";
NSString * const LFPoemsDBFolder = @"LFPoems";
NSString * const LFPoemsSqlFile = @"LFPoems.sql";

@implementation LFPoemsDatabaseHelper

#pragma mark - Life Cycle

+ (instancetype)sharedInstance {
    static LFPoemsDatabaseHelper *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[LFPoemsDatabaseHelper alloc] init];
    });
    
    return _sharedInstance;
}

#pragma mark - Setup Database

+ (NSArray *)setupSqls {
    NSString* path = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:LFPoemsSqlFile];
    NSError* error = nil;
    NSString* content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    if (content == nil) {
        NSLog(@"can't fetch the sql to create db with error:%@", error);
        return nil;
    }
    
    NSArray* sqls = [content componentsSeparatedByString:@";"];
    return sqls;
}

// 由于本应用采用默认数据库，所以不需要执行sql语句来展示处理.
// 但其实收藏功能等还是需要对数据库重新组织或者更新
+ (BOOL)setupDB {
    NSString *cacheFolder = [self cacheFolder];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:cacheFolder]) {
        [fileManager createDirectoryAtPath:cacheFolder withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    
    NSString *dbFilePath = [cacheFolder stringByAppendingPathComponent:[self defaultDBFileName]];
    BOOL isDbExist = [[NSFileManager defaultManager] fileExistsAtPath:dbFilePath];
    BOOL isFirstInstall = !isDbExist;
    BOOL bRet = YES;
    if (isFirstInstall) {
        // 获得数据库文件在工程中的路径——源路径。
        NSString *sourcesPath = [[NSBundle mainBundle] pathForResource:@"tangshi" ofType:@"db"];
        
        // dbFilePath is /Users/xiangconnie/Library/Developer/CoreSimulator/Devices/1ECBA13C-08F3-45F4-8B30-02CD4089B44F/data/Containers/Data/Application/1D47B2A4-CB48-41D6-BFDC-EDEE0DCE994D/Library/Caches/LFPoems/LFPoems.db
        NSError *error;
        if ([[NSFileManager defaultManager] copyItemAtPath:sourcesPath toPath:dbFilePath error:&error]) {
            NSLog(@"数据库移动成功");
        } else {
            NSLog(@"数据库移动失败");
        }
    } else {
//        暂时并不支持升级数据库. 将来可考虑.
    }
    
    FMDatabase* db = [[[self class] sharedInstance] getDatabase];
    [db setShouldCacheStatements:NO];
    [[[self class] sharedInstance] finish];
    
    if (isFirstInstall && ![self isAllowBackup]) {
        // 缓存数据库不要备份到iCloud.
        [LFCommonUtility addDoNotBackupAttribute:dbFilePath];
    }
    
    return bRet;
}

#pragma mark - Helper Method

+ (NSString *)defaultDBFileName {
    return LFPoemsDBName;
}

+ (NSString *)cacheFolder {
    NSArray *pathsToLibraryCache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    if ([pathsToLibraryCache isKindOfClass:[NSArray class]] && [pathsToLibraryCache count] > 0) {
        NSString *cachesDirectory = [pathsToLibraryCache objectAtIndex:0];
        return [cachesDirectory stringByAppendingPathComponent:LFPoemsDBFolder];
    }
    
    // 正常情况下不会执行到这里.
    return @"";
}

+ (BOOL)isAllowBackup {
    return NO;
}

@end

