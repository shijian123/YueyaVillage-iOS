//
//  CYYellowBagHomeController.m
//  YueyaVillage
//
//  Created by zcy on 2019/3/26.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CYYellowBagHomeController.h"
#import "CYYellowBagDetailController.h"
#import "CYReleaseYellowBagController.h"
#import "CYYellowBagHomeNavView.h"
#import "CYYellowBagListCell.h"
#import "CYYellowBagListController.h"

@interface CYYellowBagHomeController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollV;
@property (nonatomic, strong) CYYellowBagHomeNavView *navView;
@property (nonatomic, strong) CYYellowBagListController *releaseListVC;
@property (nonatomic, strong) CYYellowBagListController *enshrineListVC;
@property (nonatomic, strong) UIButton *rightNavBtn;

@end

@implementation CYYellowBagHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = self.navView;

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightNavBtn];
    self.mainScrollV.contentSize = CGSizeMake(MainScreenWidth*2, self.view.height);
    [self addChildViewController:self.releaseListVC];
    [self addChildViewController:self.enshrineListVC];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.mainScrollV.frame = self.view.bounds;
    self.mainScrollV.contentSize = CGSizeMake(MainScreenWidth*2, self.view.height);
}

- (void)startReleaseMethod {
    CYReleaseYellowBagController *releaseVC = [[CYReleaseYellowBagController alloc] initWithNibName:@"CYReleaseYellowBagController" bundle:nil];
    [self presentViewController:releaseVC animated:YES completion:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.mainScrollV) {
        [self.navView adjustNavViewWithScrollOffset:scrollView.contentOffset.x];
    }
}

- (CYYellowBagHomeNavView *)navView {
    if (_navView == nil) {
        _navView = [[NSBundle mainBundle] loadNibNamed:@"CYYellowBagHomeNavView" owner:self options:nil].firstObject;
        __weak typeof(self) ws = self;
        _navView.switchTitleBtnBlock = ^(UIButton * _Nonnull sender) {
            if (sender.tag == 100) {
                [UIView animateWithDuration:0.3 animations:^{
                    ws.mainScrollV.contentOffset = CGPointMake(0, 0);
                }];
            }else if(sender.tag == 101){
                [UIView animateWithDuration:0.3 animations:^{
                    ws.mainScrollV.contentOffset = CGPointMake(MainScreenWidth, 0);
                }];
            }
        };
    }
    return _navView;
}

- (UIButton *)rightNavBtn {
    if (_rightNavBtn == nil) {
        _rightNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightNavBtn.frame = CGRectMake(0, 0, 60, 40);
        _rightNavBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -40);
        [_rightNavBtn setTitle:@"+" forState:UIControlStateNormal];
        _rightNavBtn.titleLabel.font = [UIFont systemFontOfSize:30];
        [_rightNavBtn setTitleColor:DefaultTextBlackColor forState:UIControlStateNormal];
        [_rightNavBtn addTarget:self action:@selector(startReleaseMethod) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightNavBtn;
}

- (CYYellowBagListController *)releaseListVC {
    if (_releaseListVC == nil) {
        _releaseListVC = [[CYYellowBagListController alloc] init];
        _releaseListVC.view.frame = CGRectMake(0, 0, MainScreenWidth, self.mainScrollV.height);
        _releaseListVC.yellowBagListType = YellowBagListType_momentNews;
        [self.mainScrollV addSubview:_releaseListVC.view];

    }
    return _releaseListVC;
}

- (CYYellowBagListController *)enshrineListVC {
    if (_enshrineListVC == nil) {
        _enshrineListVC = [[CYYellowBagListController alloc] init];
        _enshrineListVC.view.frame = CGRectMake(MainScreenWidth, 0, MainScreenWidth, self.mainScrollV.height);
        _enshrineListVC.yellowBagListType = YellowBagListType_momentStarTop10;
        [self.mainScrollV addSubview:_enshrineListVC.view];

    }
    return _enshrineListVC;
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
