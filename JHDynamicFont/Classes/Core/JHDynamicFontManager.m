//
//  JHDynamicFontManager.m
//  JHDynamicFont
//
//  Created by Shenjinghao on 2017/3/14.
//  Copyright © 2017年 JHModule. All rights reserved.
//

#import "JHDynamicFontManager.h"
#import <UIKit/UIKit.h>


NSString *const JHFontDidChangeNotification = @"JHFontDidChangeNotification";
NSString *const JHFontSizeCategoryNewValueKey = @"JHFontSizeCategoryNewValueKey";
NSString *const JHDynamicFontUserDefaultKey = @"JHDynamicFontUserDefaultKey";

@implementation JHDynamicFontManager

+ (instancetype)defaultManager
{
    static JHDynamicFontManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
        [manager registerDynamicFontNotification];
    });
    return manager;
}

#pragma mark 添加通知观察者
- (void)registerDynamicFontNotification
{
    //当不同类别的字体大小发生变化时接收通知
    //// userInfo dictionary will contain new value for UIContentSizeCategoryNewValueKey
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedFontSizeChanged:) name:UIContentSizeCategoryDidChangeNotification object:nil];
}

#pragma mark 收到并传递通知
- (void)receivedFontSizeChanged:(NSNotification *)notification
{
    // NSString instance with new content size category in userInfo
    NSDictionary *dict = notification.userInfo;
    [self postDynamicFontNotificationWithContentSizeStr:dict[UIContentSizeCategoryNewValueKey]];
    
    
}

#pragma mark 发送
- (void)postDynamicFontNotificationWithContentSizeStr:(NSString *)contentSizeStr
{
    [[NSNotificationCenter defaultCenter] postNotificationName:JHFontDidChangeNotification object:nil userInfo:@{JHFontSizeCategoryNewValueKey:contentSizeStr}];
}

#pragma mark 存储在本地
- (void)saveDynamicFontSizeToUserDefault:(NSString*)dynamicFontSizeStr
{
    if (dynamicFontSizeStr == nil || [dynamicFontSizeStr isEqualToString:@""] || ![dynamicFontSizeStr isEqual:[NSString class]]) {
        return;
    }
    NSUserDefaults *info = [NSUserDefaults standardUserDefaults];
    [info setObject:dynamicFontSizeStr forKey:JHDynamicFontUserDefaultKey];
    [info synchronize];
    
}

- (NSString *)contentSizeStr
{
    return [self getUserDefaultDynamicFontSizeStr];
}

#pragma mark 获取存放本地的数据
- (NSString *)getUserDefaultDynamicFontSizeStr
{
    NSUserDefaults *info = [NSUserDefaults standardUserDefaults];
    return [info objectForKey:JHDynamicFontUserDefaultKey];
}

#pragma mark 移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
