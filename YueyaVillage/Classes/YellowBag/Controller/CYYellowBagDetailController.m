//
//  CYYellowBagDetailController.m
//  YueyaVillage
//
//  Created by zcy on 2019/3/26.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CYYellowBagDetailController.h"
#import "CYYellowBagImgsCell.h"
#define CYMAXSECTION 10

@interface CYYellowBagDetailController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *photoCollecV;
@property (weak, nonatomic) IBOutlet UIImageView *headImgV;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIImageView *collectImgV;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *showNumLab;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSArray *photoArr;

@end

@implementation CYYellowBagDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"详情";
    self.photoArr = self.model.imgUrlArr;
    self.showNumLab.text = [NSString stringWithFormat:@"1/%d", (int)self.photoArr.count];
    [self.photoCollecV registerNib:[UINib nibWithNibName:@"CYYellowBagImgsCell" bundle:nil] forCellWithReuseIdentifier:@"CYYellowBagImgsCell"];
    
    self.contentLab.text = self.model.content;

    [self.headImgV sd_setImageWithURL:[NSURL URLWithString:@"https://gss0.bdstatic.com/-4o3dSag_xI4khGkpoWK1HF6hhy/baike/Whf%3D180%2C140%2C50/sign=35b095e6af44ad340eead48ae19a3cd8/a71ea8d3fd1f4134339932752b1f95cad1c85e0a.jpg"] placeholderImage:[UIImage imageNamed:@"arvarPlaceHolder"]];
    if (self.model.isStarBySelf) {
        self.collectImgV.image = [UIImage imageNamed:@"ucColletion_19x19_"];
    }else {
        self.collectImgV.image = [UIImage imageNamed:@"ucUnColletion_19x19_"];
        
    }
    self.timeLab.text = @"2019-03-23";
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
}

- (NSIndexPath *)currentIndexPath {
    NSIndexPath *currentPath = [self.photoCollecV indexPathsForVisibleItems].lastObject;
    NSIndexPath *resetPath = [NSIndexPath indexPathForItem:currentPath.item inSection:CYMAXSECTION/2];
    [self.photoCollecV scrollToItemAtIndexPath:resetPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    return resetPath;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return CYMAXSECTION;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photoArr.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(MainScreenWidth, self.photoCollecV.height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CYYellowBagImgsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CYYellowBagImgsCell" forIndexPath:indexPath];
    cell.imgUrlArr = self.model.imgUrlArr;
    cell.backgroundColor = [UIColor purpleColor];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int page = (int)(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5) % self.photoArr.count;
    self.showNumLab.text = [NSString stringWithFormat:@"%d/%d", page+1, (int)self.photoArr.count];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (NSTimer *)timer {
    if (_timer == nil) {
        __weak typeof(self) weakSelf = self;
        _timer = [NSTimer scheduledTimerWithTimeInterval:2.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSIndexPath *currentPath = [weakSelf currentIndexPath];
            NSInteger nextRow = currentPath.item + 1;
            NSInteger nextSection = currentPath.section;
            if (nextRow == weakSelf.photoArr.count) {
                nextRow = 0;
                nextSection += 1 ;
            }
            [weakSelf.photoCollecV scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:nextRow inSection:nextSection] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
        }];
    }
    return _timer;
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
        
        if ([json[@"resultCode"] intValue] != 1000) {
            [MBProgressHUD showMessage:json[@"error"]];
            return ;
        }
        [MBProgressHUD showMessage:json[@"content"]];
        self.model.isStarBySelf = !self.model.isStarBySelf;
        if (self.model.isStarBySelf) {
            self.collectImgV.image = [UIImage imageNamed:@"ucColletion_19x19_"];
        }else {
            self.collectImgV.image = [UIImage imageNamed:@"ucUnColletion_19x19_"];
        }
        
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showMessage:@"网络请求失败"];
    }];
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
