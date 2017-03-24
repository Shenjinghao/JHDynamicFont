//
//  UILabel+JHLabelFontChange.m
//  JHDynamicFont
//
//  Created by Shenjinghao on 2017/3/16.
//  Copyright © 2017年 JHModule. All rights reserved.
//

#import "UILabel+JHLabelFontChange.h"
#import <objc/runtime.h>

@implementation UILabel (JHLabelFontChange)

#pragma mark 重写load方法，父类load方法加载完会走category
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//    willMoveToSuperview:在一个子视图将要被添加到另一个视图的时候发送此消息
        
        SEL systemSel = @selector(willMoveToSuperview:);
        
        SEL JH_sel = @selector(JH_willMoveToSuperview:);
        
//        class_getInstanceMethod     得到类的实例方法
//        class_getClassMethod          得到类的类方法
//        Method包含方法名sel和方法实现IMP
        
        Method systemMethod = class_getInstanceMethod([self class], systemSel);
        
        Method JH_method = class_getInstanceMethod([self class], JH_sel);
        
//        class_addMethod 为类添加新方法，放回yes可以添加，放回no说明已存在该方法
//        method_getTypeEncoding 获取方法的Type字符串(包含参数类型和返回值类型)
//        为当前类添加一个方法，名字sel为systemSel，方法实现为JH_method
//        [UIStatusBarBackgroundView myWillMoveToSuperview:]: unrecognized selector sent to instance 0x7ff2176020b0
        
        if (class_addMethod([self class], systemSel, method_getImplementation(JH_method), method_getTypeEncoding(JH_method))) {
//            添加成功，说明此类不包含该方法
            class_replaceMethod([self class], JH_sel, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
        }else{
//            添加失败，说明存在此方法,直接交换即可
            method_exchangeImplementations(systemMethod, JH_method);
        }
        
        
    });
}

#pragma mark 自己实现的一个新方法
- (void)JH_willMoveToSuperview:(UIView *)superView
{
    //此处调用的是系统的方法
    [self JH_willMoveToSuperview:superView];
    if ([self isKindOfClass:NSClassFromString(@"UIButtonLabel")]) {
        //按钮的样式不改变
        return;
    }
    if ([self isKindOfClass:[UILabel class]]) {
        UILabel *lable = (UILabel *)self;
        //为特殊的label打上特定的标签
        if (self.tag == 10000) {
            lable.textColor = [UIColor blueColor];
        }else{
            lable.textColor = [UIColor redColor];
        }
    }
}


@end

