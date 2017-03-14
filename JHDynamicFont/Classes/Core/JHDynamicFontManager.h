//
//  JHDynamicFontManager.h
//  JHDynamicFont
//
//  Created by Shenjinghao on 2017/3/14.
//  Copyright © 2017年 JHModule. All rights reserved.
//

#import <Foundation/Foundation.h>



extern NSString *const JHFontDidChangeNotification;
extern NSString *const JHFontSizeCategoryNewValueKey;
extern NSString *const JHDynamicFontUserDefaultKey;

/**
 动态文字管理类
 */
@interface JHDynamicFontManager : NSObject

+ (instancetype) defaultManager;

- (void)postDynamicFontNotificationWithContentSizeStr:(NSString *)contentSizeStr;

@end
