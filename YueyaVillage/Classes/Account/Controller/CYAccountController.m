//
//  CYAccountController.m
//  YueyaVillage
//
//  Created by zcy on 2019/3/16.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CYAccountController.h"
#import "CYAccountHeaderView.h"
#import "CYYellowBagListController.h"
#import "CYAccountEditNameAlertView.h"

@interface CYAccountController ()<UITableViewDelegate, UITableViewDataSource>{
    NSArray *itemArr;
}
@property (nonatomic, strong) UITableView *myTableV;
@property (nonatomic, strong) CYAccountHeaderView *headerV;
@property (nonatomic, strong) CYAccountEditNameAlertView *editNameView;

@end

@implementation CYAccountController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    itemArr = @[@"我的作品",@"我的收藏",@"查看排名"];
    self.myTableV.tableHeaderView = self.headerV;
}

- (void)editNameMethod{
    [self.editNameView show];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return itemArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELLID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELLID"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = itemArr[indexPath.row];
    cell.textLabel.textColor = DefaultTextBlackColor;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {//我的发布
        CYYellowBagListController *listVC = [[CYYellowBagListController alloc] init];
        listVC.title = @"我的发布";
        listVC.yellowBagListType = YellowBagListType_momentSelf;
        [self.navigationController pushViewController:listVC animated:YES];
    }else if (indexPath.row == 1) {//我的收藏
        CYYellowBagListController *listVC = [[CYYellowBagListController alloc] init];
        listVC.title = @"我的收藏";
        listVC.yellowBagListType = YellowBagListType_momentStar;
        [self.navigationController pushViewController:listVC animated:YES];
        
    }else if (indexPath.row == 2) {//查看排名
        
    }
}

- (UITableView *)myTableV {
    if (_myTableV == nil) {
        _myTableV = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _myTableV.delegate = self;
        _myTableV.dataSource = self;
        [self.view addSubview:self.myTableV];
    }
    return _myTableV;
}

- (CYAccountHeaderView *)headerV {
    if (_headerV == nil) {
        _headerV = [[NSBundle mainBundle] loadNibNamed:@"CYAccountHeaderView" owner:self options:nil].firstObject;
        _headerV.size = CGSizeMake(MainScreenWidth, _headerV.height);
        _headerV.headImgV.layer.borderColor = DefaultTextGrayColor.CGColor;
        _headerV.headImgV.layer.borderWidth = 0.3;
        _headerV.headImgV.contentScaleFactor = [[UIScreen mainScreen] scale];
        [_headerV.headImgV sd_setImageWithURL:[NSURL URLWithString:@"https://gss0.bdstatic.com/-4o3dSag_xI4khGkpoWK1HF6hhy/baike/Whf%3D180%2C140%2C50/sign=35b095e6af44ad340eead48ae19a3cd8/a71ea8d3fd1f4134339932752b1f95cad1c85e0a.jpg"] placeholderImage:[UIImage imageNamed:@"arvarPlaceHolder"]];
        
        [_headerV.editNameBtn addTarget:self action:@selector(editNameMethod) forControlEvents:UIControlEventTouchUpInside];

    }
    return _headerV;
}

- (CYAccountEditNameAlertView *)editNameView {
    if (_editNameView == nil) {
        _editNameView = [[NSBundle mainBundle] loadNibNamed:@"CYAccountEditNameAlertView" owner:self options:nil].firstObject;
    }
    return _editNameView;
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
