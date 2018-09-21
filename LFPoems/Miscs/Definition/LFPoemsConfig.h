//
//  LFPoemsConfig.h
//  LFPoems
//
//  Created by Wangliping on 15/12/11.
//  Copyright © 2015年 HUST. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, LFTabItemTag) {
    LFTabItemTagMain = 1,
    LFTabItemTagSearch = 2,
    LFTabItemTagFavorite = 3,
    LFTabItemTagRandom = 4,
    LFTabItemTagSetting = 5
};

@interface LFPoemsConfig : NSObject

//+ (instancetype)sharedInstance;

@end
