//
//  CYTabBarController.m
//  YueyaVillage
//
//  Created by zcy on 2019/3/16.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CYTabBarController.h"
#import "CYNavigationController.h"
#import "CYHomeController.h"
#import "CYAccountController.h"

@interface CYTabBarController ()

@end

@implementation CYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化子控制器
    [self addSubViews];
}

#pragma mark - custom method

- (void)addSubViews{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenSize.width, 49)];
    backView.backgroundColor = [UIColor clearColor];
    [self.tabBar insertSubview:backView atIndex:0];
    self.tabBar.opaque = YES;
    
    CYHomeController *homeVC = [[CYHomeController alloc] init];
    [self addChildVc:homeVC title:@"Home" tabBarItemTitle:@"Home" image:@"" selectedImage:@""];
    
    CYAccountController *accountVC = [[CYAccountController alloc] init];
    [self addChildVc:accountVC title:@"Account" tabBarItemTitle:@"Account" image:@"" selectedImage:@""];
}

- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title tabBarItemTitle:(NSString *)itemTitle image:(NSString *)image selectedImage:(NSString *)selectedImage{

    childVc.title = title;
    childVc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.title = itemTitle;
    
    CYNavigationController *nav = [[CYNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
