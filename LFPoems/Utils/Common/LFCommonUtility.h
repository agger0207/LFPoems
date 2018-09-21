//
//  LFCommonUtility.h
//  LFPoems
//
//  Created by Wangliping on 15/12/11.
//  Copyright © 2015年 HUST. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LFCommonUtility : NSObject

/**
 *  设置指定路径的文件不备份到iCloud.
 *
 *  @param path 文件路径
 */
+ (void)addDoNotBackupAttribute:(NSString *)path;

/**
 *  计算md5值
 *
 *  @param string 计算结果
 *
 *  @return 传入的字符串
 */
+ (NSString *)md5StringFromString:(NSString *)string;

/**
 *  应用版本号
 *
 *  @return 应用版本号
 */
+ (NSString *)appVersionString;

@end
