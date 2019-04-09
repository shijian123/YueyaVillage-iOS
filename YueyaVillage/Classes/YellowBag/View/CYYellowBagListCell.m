//
//  CYYellowBagListCell.m
//  YueyaVillage
//
//  Created by zcy on 2019/3/26.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CYYellowBagListCell.h"

@interface CYYellowBagListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *photoImgV;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UIImageView *headImgV;
@property (weak, nonatomic) IBOutlet UIImageView *collectImgV;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@end

@implementation CYYellowBagListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(CYYellowBagListModel *)model {
    _model = model;
    
    if (model.imgUrlArr.count <= 0) {
        NSArray *imgArr = [model.imgurl componentsSeparatedByString:@";"];
        if (imgArr.count == 0) {//没有图片添加默认图
            imgArr = @[@"https://pics1.baidu.com/feed/342ac65c10385343d5d354922a7b257acb8088d6.jpeg?token=c090bd80e3b0a0a7669f06ec4d39135a&s=4A064984403231825C38997903008050"];
        }
        model.imgUrlArr = imgArr;

    }
    
    self.photoImgV.layer.borderColor = DefaultLineGrayColor.CGColor;
    self.photoImgV.layer.borderWidth = 0.3;
    self.photoImgV.contentScaleFactor = [[UIScreen mainScreen] scale];

    self.headImgV.layer.borderColor = DefaultLineGrayColor.CGColor;
    self.headImgV.layer.borderWidth = 0.3;
    self.headImgV.contentScaleFactor = [[UIScreen mainScreen] scale];
    NSString *imgStr = [NSString stringWithFormat:@"%@%@", CYBASEURL, model.imgUrlArr[0]];
    [self.photoImgV sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"newsDetailPlaceholer"]];
    self.contentLab.text = model.content;
//    self.contentLab.text = @"ycy看过来呀ycy看过来呀ycy看过来呀ycy看过来呀ycy看过来呀ycy看过来呀ycy看过来呀ycy看过来呀ycy看过来呀ycy看过来呀ycy看过来呀ycy看过来呀ycy看过来呀ycy看过来呀";
    [self.headImgV sd_setImageWithURL:[NSURL URLWithString:@"https://gss0.bdstatic.com/-4o3dSag_xI4khGkpoWK1HF6hhy/baike/Whf%3D180%2C140%2C50/sign=35b095e6af44ad340eead48ae19a3cd8/a71ea8d3fd1f4134339932752b1f95cad1c85e0a.jpg"] placeholderImage:[UIImage imageNamed:@"arvarPlaceHolder"]];
    if (model.isStarBySelf) {
        self.collectImgV.image = [UIImage imageNamed:@"ucColletion_19x19_"];
    }else {
        self.collectImgV.image = [UIImage imageNamed:@"ucUnColletion_19x19_"];

    }
    self.timeLab.text = [model.create_date timeIntervalFromNow];
}

/**
 收藏
 */
- (IBAction)collectItemAction:(id)sender {
    [self requestServerIsStar];
}


/**
 点赞和取消赞
 */
- (void)requestServerIsStar{
    NSString *urlS = @"addStar";
    if(self.model.isStarBySelf) {
        urlS = @"cancelStar";
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", CYBASEURL, urlS];
    [CYHttpTool get:urlStr params:@{@"moment_id":self.model.moment_id} success:^(id  _Nonnull json) {
        
        if ([json[@"resultCode"] intValue] != 1000) {//
            [MBProgressHUD showMessage:json[@"error"]];
            return ;
        }
        [MBProgressHUD showMessage:json[@"content"]];
        self.model.isStarBySelf = !self.model.isStarBySelf;
        if (self.reloadTableViewBlock) {
            self.reloadTableViewBlock();
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showMessage:@"网络请求失败"];
    }];
}


@end
