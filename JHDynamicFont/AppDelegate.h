//
//  AppDelegate.h
//  JHDynamicFont
//
//  Created by Shenjinghao on 2017/3/13.
//  Copyright © 2017年 JHModule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

