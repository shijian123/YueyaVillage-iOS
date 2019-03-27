//
//  CYLoginViewController.m
//  YueyaVillage
//
//  Created by ZHANGMING on 2019/3/24.
//  Copyright © 2019年 CY. All rights reserved.
//

#import "CYLoginViewController.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

@interface CYLoginViewController () <TencentSessionDelegate,TencentLoginDelegate>

@property (nonatomic,strong) UIImageView * headerView;
@property (nonatomic,strong) UIButton * loginBtn ;
@property (nonatomic,strong) UIButton * touristLoginBtn;
@property (strong,nonatomic) TencentOAuth  * tencentOAuth  ;


@end

@implementation CYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI {
    
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.touristLoginBtn];
}

/** 点击登陆 */
- (void)clickedLoginBtn:(UIButton *)button {
    
    if ([QQApiInterface isQQInstalled] && [QQApiInterface isQQSupportApi]) {
        
        NSArray * permissons = @[kOPEN_PERMISSION_GET_SIMPLE_USER_INFO];
        
        self.tencentOAuth = [[TencentOAuth alloc]initWithAppId:@"101557229" andDelegate:self];
        
        self.tencentOAuth.authMode = kAuthModeClientSideToken;
        
        self.tencentOAuth.redirectURI = @"";
        
        self.tencentOAuth.authShareType = AuthShareType_QQ;
        
        [self.tencentOAuth authorize:permissons inSafari:NO];
        
    }
}

-(void)tencentDidLogin {
    
    NSLog(@"_tencentOAuth.openId = %@",self.tencentOAuth.openId);
    
    [self.tencentOAuth getUserInfo];
}

-(void)getUserInfoResponse:(APIResponse *)response {
    
    NSLog(@"res = %@",response.jsonResponse);
}

#pragma 懒加载

- (UIImageView *)headerView {
    if (!_headerView) {
        CGFloat x = ( MainScreenWidth - 90 ) / 2 ;
        _headerView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
        _headerView.contentMode = UIViewContentModeScaleAspectFit;
        _headerView.frame = CGRectMake(x,MainScreenHeight / 2 - 200,90,90);
        _headerView.layer.cornerRadius = 90 / 2 ;
        _headerView.clipsToBounds = YES;
        _headerView.layer.backgroundColor = [UIColor colorWithRed:242/255.0 green:241/255.0 blue:246/255.0 alpha:1.0].CGColor;
    } return _headerView ;
}


-(UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginBtn.frame = CGRectMake(30, MainScreenHeight / 2 - 40, MainScreenWidth - 60, 50);
        //_loginBtn.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
        _loginBtn.backgroundColor = [UIColor lightGrayColor];
        _loginBtn.layer.cornerRadius = 10 ;
        [_loginBtn setTitle:@"微信登陆" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(clickedLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
    } return _loginBtn;
}

-(UIButton *)touristLoginBtn {
    if (!_touristLoginBtn) {
        _touristLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _touristLoginBtn.frame = CGRectMake(30, MainScreenHeight / 2 + 50, MainScreenWidth - 60, 50);
        //_touristLoginBtn.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
        _touristLoginBtn.backgroundColor = [UIColor lightGrayColor];
        _touristLoginBtn.layer.cornerRadius = 10 ;
        [_touristLoginBtn setTitle:@"游客登陆" forState:UIControlStateNormal];
        [_touristLoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_touristLoginBtn addTarget:self action:@selector(clickedLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
    } return _touristLoginBtn;
}

@end
