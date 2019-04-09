//
//  CYYellowBagImgsCell.m
//  YueyaVillage
//
//  Created by zcy on 2019/4/8.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CYYellowBagImgsCell.h"

@interface CYYellowBagImgsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *photoImgV;

@end

@implementation CYYellowBagImgsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setImgUrlArr:(NSArray *)imgUrlArr {
    _imgUrlArr = imgUrlArr;
    [self.photoImgV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", CYBASEURL, imgUrlArr[0]]] placeholderImage:[UIImage imageNamed:@"newsDetailPlaceholer"]];
    self.photoImgV.contentScaleFactor = [[UIScreen mainScreen] scale];

}


@end
