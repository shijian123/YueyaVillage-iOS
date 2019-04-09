//
//  CYYellowBagListMyCell.m
//  YueyaVillage
//
//  Created by zcy on 2019/4/9.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CYYellowBagListMyCell.h"

@interface CYYellowBagListMyCell ()
@property (weak, nonatomic) IBOutlet UILabel *contentLab;

@property (weak, nonatomic) IBOutlet UIView *collecInfoView;
@property (weak, nonatomic) IBOutlet UIImageView *headImgV;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIImageView *collectImgV;

@property (weak, nonatomic) IBOutlet UIView *releaseInfoView;
@property (weak, nonatomic) IBOutlet UILabel *releaseTimeLab;

@property (weak, nonatomic) IBOutlet UIImageView *photoImgV;

@end

@implementation CYYellowBagListMyCell

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
            imgArr = @[@"arvarPlaceHolder.png"];
        }
        model.imgUrlArr = imgArr;
        
    }
    
    if (self.isMyRelease) {//我的发布
        self.collecInfoView.hidden = YES;
        self.releaseInfoView.hidden = NO;
    }else {
        self.releaseInfoView.hidden = YES;
        self.collecInfoView.hidden = NO;
        
        self.headImgV.layer.borderColor = DefaultLineGrayColor.CGColor;
        self.headImgV.layer.borderWidth = 0.3;
        self.headImgV.contentScaleFactor = [[UIScreen mainScreen] scale];
        [self.headImgV sd_setImageWithURL:[NSURL URLWithString:@"https://gss0.bdstatic.com/-4o3dSag_xI4khGkpoWK1HF6hhy/baike/Whf%3D180%2C140%2C50/sign=35b095e6af44ad340eead48ae19a3cd8/a71ea8d3fd1f4134339932752b1f95cad1c85e0a.jpg"] placeholderImage:[UIImage imageNamed:@"arvarPlaceHolder"]];
        if (model.isStarBySelf) {
            self.collectImgV.image = [UIImage imageNamed:@"ucColletion_19x19_"];
        }else {
            self.collectImgV.image = [UIImage imageNamed:@"ucUnColletion_19x19_"];
            
        }
    }

    self.contentLab.text = model.content;

    self.photoImgV.contentScaleFactor = [[UIScreen mainScreen] scale];
    NSString *imgStr = [NSString stringWithFormat:@"%@%@", CYBASEURL, model.imgUrlArr[0]];
    [self.photoImgV sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"newsDetailPlaceholer"]];
    self.timeLab.text = [model.create_date timeIntervalFromNow];
}


@end
