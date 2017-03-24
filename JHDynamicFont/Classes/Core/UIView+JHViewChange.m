//
//  UIView+JHViewChange.m
//  JHDynamicFont
//
//  Created by Shenjinghao on 2017/3/21.
//  Copyright © 2017年 JHModule. All rights reserved.
//

#import "UIView+JHViewChange.h"
#import <objc/runtime.h>

@implementation UIView (JHViewChange)

+ (void)load {
    //方法交换应该被保证，在程序中只会执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL systemSel = @selector(setBackgroundColor:);
        
        SEL JH_sel = @selector(JHSetChangeColor:);
        
        Method systemMethod = class_getInstanceMethod([self class], systemSel);
        
        Method JH_method = class_getInstanceMethod([self class], JH_sel);
        
        //此处不需要再分别进行交换，直接exchange就可以
        
//        BOOL isAdd = class_addMethod(self, systemSel, method_getImplementation(JH_method), method_getTypeEncoding(JH_method));
//        if (isAdd) {
//            class_replaceMethod(self, JH_sel, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
//        } else {
//            method_exchangeImplementations(systemMethod, JH_method);
//        }
        
        method_exchangeImplementations(systemMethod, JH_method);
    });
}

#pragma mark 自己实现的一个新方法
- (void)JHSetChangeColor:(UIColor *)color
{
    //此处调用的是系统的方法
    [self JHSetChangeColor:color];
    if ([self isKindOfClass:[UIButton class]]) {
        
        UIButton *button = (UIButton *)self;
        //为特殊的label打上特定的标签
        if (self.tag == 10000) {
            [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        } else {
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        return;
    }
}



@end
