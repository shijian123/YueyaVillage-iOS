//
//  CYYellowBagHomeNavView.m
//  YueyaVillage
//
//  Created by zcy on 2019/3/26.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CYYellowBagHomeNavView.h"

@interface CYYellowBagHomeNavView ()
@property (weak, nonatomic) IBOutlet UILabel *leftTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *rightTitleLab;
@property (weak, nonatomic) IBOutlet UIImageView *selectImgV;

@end

@implementation CYYellowBagHomeNavView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)adjustNavViewWithScrollOffset:(CGFloat)offset{
    CGFloat scale;
    if (offset <= MainScreenWidth && offset >= 0) {
        scale = MIN(MAX(1.0-offset/MainScreenWidth, 0), 1.0);
        if (scale > 0.6) {//左
            self.leftTitleLab.textColor = [UIColor whiteColor];
            self.rightTitleLab.textColor = DefaultTextBlackColor;
        }else{//右
            self.rightTitleLab.textColor = [UIColor whiteColor];
            self.leftTitleLab.textColor = DefaultTextBlackColor;
        }
        self.selectImgV.origin = CGPointMake((self.rightTitleLab.x-self.leftTitleLab.x)*MIN(offset/MainScreenWidth, 1.0), self.selectImgV.y);
    }
}

- (IBAction)switchTitleAction:(UIButton *)sender {
    if (self.switchTitleBtnBlock){
        self.switchTitleBtnBlock(sender);
    }
}

@end
