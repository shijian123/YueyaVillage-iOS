//
//  CYHomeController.m
//  YueyaVillage
//
//  Created by zcy on 2019/3/16.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CYHomeController.h"
#import "CYAccountController.h"
#import "CYLoginViewController.h"

@interface CYHomeController ()

@end

@implementation CYHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    // Do any additional setup after loading the view.
    
    CYLoginViewController * loginVC = [[CYLoginViewController alloc]init];
    [self presentViewController:loginVC animated:YES completion:nil];
    
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
