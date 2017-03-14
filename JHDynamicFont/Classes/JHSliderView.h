//
//  JHSliderView.h
//  JHDynamicFont
//
//  Created by Shenjinghao on 2017/3/13.
//  Copyright © 2017年 JHModule. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^JHSliderValuerDidChangedBlock)(NSInteger index);

/**
 设置字体的slider
 */
@interface JHSliderView : UIView

@property (nonatomic) NSInteger currentIndex;   //default is 3;

@property (nonatomic, copy) JHSliderValuerDidChangedBlock changedBlock;

+ (instancetype)sliderViewWithFrame:(CGRect)frame options:(NSArray *)options valueDidChangedBlokck:(JHSliderValuerDidChangedBlock)changedBlock;



@end
