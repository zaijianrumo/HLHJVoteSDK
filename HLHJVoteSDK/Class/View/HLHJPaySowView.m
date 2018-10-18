//
//  HLHJPaySowView.m
//  HLHJVoteSDK
//
//  Created by mac on 2018/8/7.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "HLHJPaySowView.h"
#import <CoreImage/CoreImage.h>
#import <Photos/Photos.h>
@interface HLHJPaySowView()

@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UIButton  *saveBtn;
@property (nonatomic, strong) UIButton  *shibieBtn;
@property (nonatomic, strong) UIButton  *canceBtn;

@property (nonatomic, strong) UIImageView  *ercodeImg;

@property (nonatomic, strong) NSString  *imageUrl;

@property (nonatomic, strong) CIImage *image;
@end



@implementation HLHJPaySowView

-(instancetype)initWithDateSource:(id)data {
    self = [super init];
    if (self) {
        
        self.frame = [UIScreen mainScreen].bounds;

        
         [self addSubview:self.canceBtn];
        
//         [self addSubview:self.saveBtn];
        
          [self addSubview:self.shibieBtn];
        
          [self addSubview:self.alertView];
        
          [self.alertView addSubview:self.ercodeImg];
    
          _imageUrl =  data;
        
        
        // 1. 创建一个二维码滤镜实例(CIFilter)
        CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
        // 滤镜恢复默认设置
        [filter setDefaults];
        // 2. 给滤镜添加数据
        NSString *string = _imageUrl;
        NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
        // 使用KVC的方式给filter赋值
        [filter setValue:data forKeyPath:@"inputMessage"];
        
        // 3. 生成二维码
        _image = [filter outputImage];

        
        
    }
    return self;
}
- (void)showPayView {
    
    self.backgroundColor = [UIColor clearColor];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
  
    self.alertView.alpha = 0;
    
    
    CGFloat height  = [UIScreen mainScreen].bounds.size.height;
    
    CGFloat width  = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat btnHeight = 48;

    self.alertView.frame = CGRectMake((width-250)/2,height + (height-250)/2,250,250);
    
    self.ercodeImg.frame = CGRectMake(self.alertView.frame.origin.x, self.alertView.frame.origin.y, self.alertView.frame.size.width-30, self.alertView.frame.size.height-30);
    
    self.canceBtn.frame = CGRectMake(0,height+btnHeight,width,btnHeight);
    
    self.shibieBtn.frame = CGRectMake(0,height+btnHeight*2-1,width,btnHeight);
    
//    self.saveBtn.frame = CGRectMake(0,height+btnHeight*3-1.5,width,btnHeight);
    
    [UIView animateWithDuration:1 animations:^{

    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.3
                         animations:^{
              
                            
                             self.alertView.frame = CGRectMake((width-250)/2,(height-250)/2,250,250);
                             
                             self.ercodeImg.frame = CGRectMake(15, 15, self.alertView.frame.size.width-30, self.alertView.frame.size.height-30);
                             
                             self.ercodeImg.image = [self createNonInterpolatedUIImageFormCIImage:self.image withSize:self.alertView.frame.size.height-30];
                             
                             
                             self.canceBtn.frame = CGRectMake(0,height-btnHeight,width,btnHeight);
                             
                             self.shibieBtn.frame = CGRectMake(0,height-btnHeight*2-1,width,btnHeight);
                             
                             
                            self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.4f];
                             
                            self.alertView.alpha = 1;
                             
                         }completion:^(BOOL finish){

                         }];
    }];
}
- (void)saveAction:(UIButton *)sender {
    
      UIImageWriteToSavedPhotosAlbum(self.ercodeImg.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
     [self hiddenAction];
    
}
-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *msg = nil ;
    if(error){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    [HLHJVoteToast hsShowBottomWithText:msg];
}

- (void)hiddenAction {
    [self hidenView];
}

-(void)hidenView {
    [self removeFromSuperview];
}
- (UIView *)alertView {
    if (!_alertView) {
        _alertView = [[UIView alloc] init];
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.layer.masksToBounds = YES;
        _alertView.layer.cornerRadius = 5;
        _alertView.userInteractionEnabled = YES;
    }
    return _alertView;
}

- (UIButton *)canceBtn {
    if(!_canceBtn){
        _canceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_canceBtn setTitle:@"取消" forState:UIControlStateNormal];
        _canceBtn.backgroundColor = [UIColor whiteColor];
        [_canceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _canceBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_canceBtn addTarget:self action:@selector(hiddenAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _canceBtn;
}
- (UIButton *)saveBtn {
    if(!_saveBtn){
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveBtn setTitle:@"保存图片" forState:UIControlStateNormal];
        _saveBtn.backgroundColor = [UIColor whiteColor];
        [_saveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _saveBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_saveBtn addTarget:self action:@selector(hiddenAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
}
- (UIButton *)shibieBtn {
    
    if(!_shibieBtn){
        _shibieBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shibieBtn setTitle:@"保存图片" forState:UIControlStateNormal];
        _shibieBtn.backgroundColor = [UIColor whiteColor];
        [_shibieBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _shibieBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_shibieBtn addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shibieBtn;
}
- (UIImageView *)ercodeImg {
    
    if (!_ercodeImg) {
        _ercodeImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, self.alertView.frame.size.width-30, self.alertView.frame.size.height-30)];
        _ercodeImg.contentMode = UIViewContentModeScaleAspectFill;
        _ercodeImg.clipsToBounds = YES;
    }
    return _ercodeImg;
    
}
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}
@end
