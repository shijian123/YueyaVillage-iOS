//
//  CYReleaseYellowBagController.m
//  YueyaVillage
//
//  Created by zcy on 2019/3/26.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CYReleaseYellowBagController.h"
#import "TZImagePickerController.h"
#import "CYPhotoSelectCell.h"

@interface CYReleaseYellowBagController ()<UITextViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UITextView *contentTV;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLab;
@property (weak, nonatomic) IBOutlet UICollectionView *photoCollecV;
@property (nonatomic) NSInteger imgUploadNum;

@property (nonatomic, strong) NSArray *imgAssets;
@property (nonatomic, strong) NSArray *imgPhotoArr;
@property (nonatomic, strong) NSMutableArray *imgUrlArr;
@property (nonatomic, strong) TZImagePickerController *imagePickerVC;
@property (nonatomic, strong) TZPhotoPreviewController *photoPreviewVC;

@end

@implementation CYReleaseYellowBagController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.imgAssets = [NSArray array];
    self.imgPhotoArr = @[];
    
    [self.photoCollecV registerNib:[UINib nibWithNibName:@"CYPhotoSelectCell" bundle:nil] forCellWithReuseIdentifier:@"CYPhotoSelectCell"];
}

- (void)selectImgPhotoArr{
    [self presentViewController:self.imagePickerVC animated:YES completion:nil];
}

- (IBAction)closeReleaseAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)startReleaseAction:(id)sender {
    
    if (![self.contentTV.text isCheckNickName]){
        [MBProgressHUD showMessage:@"包含非法字符"];
        return;
    }
    self.imgUploadNum = 0;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:true];
    if (self.imgPhotoArr.count > 0) {//有图片
        self.imgUrlArr = [NSMutableArray arrayWithCapacity:0];
        [self requestServerUploadImg:self.imgPhotoArr[self.imgUploadNum] showHud:hud];
    }else{//无图片
        [MBProgressHUD showMessage:@"选个好看的图片分享给大家吧^_^"];
    }

}

- (void)textViewDidChange:(UITextView *)textView{
    
    self.placeholderLab.hidden = textView.text.length;
    
    CGSize size = [textView sizeThatFits:CGSizeMake(MainScreenWidth-40, MAXFLOAT)];
    if (size.height > 50 && size.height < 120){
        if (size.height - self.contentTV.height > 5) {
            self.contentTV.height = size.height;
            self.photoCollecV.origin = CGPointMake(self.photoCollecV.x, CGRectGetMaxY(self.contentTV.frame)+20);
        }
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.imgPhotoArr.count >= 9) {
        return 9;
    }else{
        return self.imgPhotoArr.count+1;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((MainScreenWidth-60)/3.0, (MainScreenWidth-60)/3.0);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CYPhotoSelectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CYPhotoSelectCell" forIndexPath:indexPath];
    cell.imgView.contentScaleFactor = [[UIScreen mainScreen] scale];
    if (self.imgPhotoArr.count < 9 && indexPath.row == self.imgPhotoArr.count) {
        cell.imgView.image = [UIImage imageNamed:@"add_image"];
    }else {
        cell.imgView.image = self.imgPhotoArr[indexPath.row];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.imgPhotoArr.count < 9 && indexPath.row == self.imgPhotoArr.count) {
        [self selectImgPhotoArr];
    }else {
        TZImagePickerController *previewVC = [[TZImagePickerController alloc] initWithSelectedAssets:[NSMutableArray arrayWithArray:self.imgAssets] selectedPhotos:[NSMutableArray arrayWithArray:self.imgPhotoArr] index:indexPath.row];
        previewVC.maxImagesCount = 9;
        previewVC.showSelectBtn = YES;
        previewVC.showSelectedIndex = YES;
        __weak typeof(self)weakSelf = self;
        [previewVC setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            weakSelf.imgAssets = assets;
            weakSelf.imgPhotoArr = photos;
            [weakSelf.photoCollecV reloadData];
        }];
        [self presentViewController:previewVC animated:YES completion:nil];
    }
}

- (TZImagePickerController *)imagePickerVC {
    if (_imagePickerVC == nil) {
        NSMutableArray *assetsArrM = [NSMutableArray array];
        [assetsArrM addObjectsFromArray:self.imgAssets];
        NSInteger maxNum = 9;
        _imagePickerVC = [[TZImagePickerController alloc] init];
        _imagePickerVC.maxImagesCount = maxNum;
        _imagePickerVC.isSelectOriginalPhoto = NO;
        _imagePickerVC.showSelectBtn = (maxNum - 1);
        _imagePickerVC.selectedAssets = assetsArrM;
        _imagePickerVC.allowTakeVideo = NO;   // 在内部显示拍视频按
        _imagePickerVC.allowCameraLocation = NO;
        _imagePickerVC.showPhotoCannotSelectLayer = YES;
        // 自定义导航栏上的返回按钮
        [_imagePickerVC setNavLeftBarButtonSettingBlock:^(UIButton *leftButton){
            [leftButton setImage:[UIImage imageNamed:@"return_white"] forState:UIControlStateNormal];
            [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 20)];
        }];
        
        [_imagePickerVC setPhotoPickerPageUIConfigBlock:^(UICollectionView *collectionView, UIView *bottomToolBar, UIButton *previewButton, UIButton *originalPhotoButton, UILabel *originalPhotoLabel, UIButton *doneButton, UIImageView *numberImageView, UILabel *numberLabel, UIView *divideLine) {
            [doneButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }];
        _imagePickerVC.allowPickingVideo = NO;
        _imagePickerVC.allowPickingOriginalPhoto = NO;
        
        __weak typeof(self)weakSelf = self;
        // 是否显示图片序号
        _imagePickerVC.showSelectedIndex = YES;
        [_imagePickerVC setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            weakSelf.imgAssets = assets;
            weakSelf.imgPhotoArr = photos;
            [weakSelf.photoCollecV reloadData];
        }];
    }
    return _imagePickerVC;
}

/**
 上传图片
 */
- (void)requestServerUploadImg:(UIImage *)img showHud:(MBProgressHUD *)hud{
    hud.labelText = @"正在上传图片";
    NSString *urlStr = [NSString stringWithFormat:@"%@upload", CYBASEURL];
    [CYHttpTool post:urlStr params:@{} image:img success:^(id _Nonnull json) {
        if ([json[@"resultCode"] intValue] != 1000) {
            [MBProgressHUD showMessage:json[@"error"]];
        }else {
            [self.imgUrlArr addObject:json[@"content"]];
            self.imgUploadNum++;
            if (self.imgPhotoArr.count > self.imgUploadNum) {
                [self requestServerUploadImg:self.imgPhotoArr[self.imgUploadNum] showHud:hud];
            }else {//上传完成
                [hud hide:YES afterDelay:0.3];
                [self requestServerAddMomentWithImgUrlArr:self.imgUrlArr];
            }
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showMessage:@"网络请求失败"];

    }];
    
}

/**
 发布小黄包
 */
- (void)requestServerAddMomentWithImgUrlArr:(NSArray *)imgUrls {
    
    NSMutableString * imgStr = [NSMutableString stringWithString:@""];
    for (NSString *str in imgUrls) {
        [imgStr appendString:str];
        [imgStr appendString:@";"];
    }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"content"] = self.contentTV.text;
    param[@"imgurl"] = imgStr;

    NSString *urlStr = [NSString stringWithFormat:@"%@addMoment", CYBASEURL];
    [CYHttpTool post:urlStr params:param success:^(id _Nonnull json) {
        if ([json[@"resultCode"] intValue] != 1000) {
            [MBProgressHUD showMessage:json[@"error"]];
        }else {
            [MBProgressHUD showMessage:@"发布成功"];
            sleep(2);
            [self dismissViewControllerAnimated:YES completion:nil];
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
