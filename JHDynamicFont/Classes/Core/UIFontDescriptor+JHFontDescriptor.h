//
//  UIFontDescriptor+JHFontDescriptor.h
//  JHDynamicFont
//
//  Created by Shenjinghao on 2017/3/13.
//  Copyright © 2017年 JHModule. All rights reserved.
//

#import <UIKit/UIKit.h>

//多扩展了两种类型
extern NSString *const JHFontTextStyleCaption3;
extern NSString *const JHFontTextStyleCaption4;

/**
 核心 - 字体设置类 （如果开始搭框架时设置，最好使用继承来设置，category是为了方便在原有基础上修改）
 */
@interface UIFontDescriptor (JHFontDescriptor)


/**
 字体描述的扩展

 @param style 样式
 @param contentString string
 @return 字体描述后
 */
+ (UIFontDescriptor *)JH_preferredFontDescriptorWithTextStyle:(UIFontTextStyle)style contentString:(NSString *)contentString;

+ (UIFontDescriptor *)JH_preferredBoldFontDescriptorWithTextStyle:(UIFontTextStyle)style contentString:(NSString *)contentString;

+ (UIFontDescriptor *)JH_fontDescriptorWithSymbolicTraits:(UIFontDescriptorSymbolicTraits)symbolicTraits textStyle:(UIFontTextStyle)style contentString:(NSString *)contentString;

@end
