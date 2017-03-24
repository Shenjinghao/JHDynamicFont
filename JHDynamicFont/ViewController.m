//
//  ViewController.m
//  JHDynamicFont
//
//  Created by Shenjinghao on 2017/3/13.
//  Copyright © 2017年 JHModule. All rights reserved.
//

#import "ViewController.h"
#import "JHDynamicFontManager.h"
#import "UIFontDescriptor+JHFontDescriptor.h"
#import "JHSliderView.h"

@interface ViewController ()

@property (nonatomic, strong) UILabel* textLabel;
@property (nonatomic, strong) JHSliderView *sliderView;

@end

@implementation ViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    [JHDynamicFontManager defaultManager];
    
    _sliderView = [JHSliderView sliderViewWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 100) options:@[@"特小", @"很小", @"小", @"正常", @"大", @"很大", @"特大"] valueDidChangedBlokck:^(NSInteger index) {
        NSString* contentStr = @"";
        if (index == 0) {
            
            contentStr = UIContentSizeCategoryExtraSmall;
        }else if (index == 1)
        {
            contentStr = UIContentSizeCategorySmall;
        }else if (index == 2)
        {
            contentStr = UIContentSizeCategoryMedium;
        }else if (index == 3){
            
            contentStr = UIContentSizeCategoryLarge;
        }
        else if (index == 4){
            
            contentStr = UIContentSizeCategoryExtraExtraLarge;
        }else if (index == 5)
        {
            contentStr = UIContentSizeCategoryAccessibilityMedium;
        }else if (index == 6)
        {
            contentStr = UIContentSizeCategoryAccessibilityExtraLarge;
        }else if (index == 7)
        {
            contentStr = UIContentSizeCategoryAccessibilityExtraExtraLarge;
        }else {
            contentStr = UIContentSizeCategoryMedium;
        }
        
        NSLog(@"当前optopn是 %ld",index);
        
        [[JHDynamicFontManager defaultManager] postDynamicFontNotificationWithContentSizeStr:contentStr];
    }];
    [self.view addSubview:_sliderView];
    
    _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, 100)];
    [_textLabel setText:@"这一行就是让你看看效果！！！"];
    [_textLabel setTextAlignment:NSTextAlignmentCenter];
    [_textLabel setBackgroundColor:[UIColor whiteColor]];
    
    UIFontDescriptor* descpripter = [UIFontDescriptor                                                                                                                             JH_preferredFontDescriptorWithTextStyle:JHFontTextStyleCaption4 contentString:UIContentSizeCategoryExtraLarge];
    _textLabel.font = [UIFont fontWithDescriptor:descpripter size:0.0];
    [self.view addSubview:_textLabel];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedFontSizeChanged:) name:JHFontDidChangeNotification object:nil];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = 10000;
    button.backgroundColor = [UIColor grayColor];
    button.frame = CGRectMake(15, 400, self.view.frame.size.width - 30, 45);
    [button setTitle:[NSString stringWithFormat:@" 测试UIButtonLabel字体颜色 "] forState:UIControlStateNormal];
    [self.view addSubview:button];
    
}

- (void)receivedFontSizeChanged:(NSNotification *)notification
{
    // NSString instance with new content size category in userInfo
    NSDictionary *dict = notification.userInfo;
    NSString *contentSizeStr = dict[JHFontSizeCategoryNewValueKey];
    UIFontDescriptor *descriptor = [UIFontDescriptor JH_preferredFontDescriptorWithTextStyle:UIFontTextStyleBody contentString:contentSizeStr];
    _textLabel.font = [UIFont fontWithDescriptor:descriptor size:0.0];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
