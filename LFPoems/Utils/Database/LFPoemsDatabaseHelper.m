//
//  LFPoemsDatabaseHelper.m
//  LFPoems
//
//  Created by Wangliping on 15/12/11.
//  Copyright © 2015年 HUST. All rights reserved.
//

#import "LFPoemsDatabaseHelper.h"
#import "FMDatabaseQueue.h"

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

