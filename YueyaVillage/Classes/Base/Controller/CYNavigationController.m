//
//  CYNavigationController.m
//  YueyaVillage
//
//  Created by zcy on 2019/3/16.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CYNavigationController.h"

@interface CYNavigationController ()

@end

@implementation CYNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
        leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
        [leftBtn setImage:[UIImage imageNamed:@"base_return"] forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    }
    [super pushViewController:viewController animated:animated];

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
