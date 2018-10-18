//
//  HLHJSingupContentView.m
//  HLHJVoteSDK
//
//  Created by mac on 2018/8/7.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "HLHJSingupContentView.h"
#import "HLHJVoteRuleView.h"
#import "HLHJVoteActivityDetilModel.h"
#import "NSString+HLHJExtention.h"
@interface HLHJSingupContentView()<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIView  *bgView;

@property (nonatomic, strong) UITextField  *nameFiled;

@property (nonatomic, strong) UITextField  *phoneFiled;

@property (nonatomic, strong) UITextView   *desTextView;

@property (strong, nonatomic) UIActionSheet *actionSheet;

@property (nonatomic, strong) UIButton      *sctpBtn;

@property (nonatomic, strong) UIButton      *delBtn;

@property (nonatomic, strong)  HLHJVoteRuleView *votRule;

@property (nonatomic, assign) BOOL  isChoooseImg;
@end

static const  CGFloat Kmargin = 10;

@implementation HLHJSingupContentView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self == [super initWithFrame:frame]) {
        
        [self setContentUI];
        
        //报名时间
        UILabel *timeStartlab = [[UILabel alloc] init];
        timeStartlab.text = @"报名时间：2018-2-20至2018-3-20";
        timeStartlab.font = [UIFont systemFontOfSize:13];
        timeStartlab.textAlignment = NSTextAlignmentCenter;
        timeStartlab.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        [self addSubview:timeStartlab];
        _singUpTimeLab = timeStartlab;
        
        
        [timeStartlab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.bgView.mas_bottom).mas_offset(Kmargin  * 2.5);
        }];
    
         //投票时间
        UILabel *timeVotelab = [[UILabel alloc] init];
        timeVotelab.text = @"投票时间：2018-2-20至2018-3-20";
        timeVotelab.font = [UIFont systemFontOfSize:13];
        timeVotelab.textAlignment = NSTextAlignmentCenter;
        timeVotelab.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        [self addSubview:timeVotelab];
        [timeVotelab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(timeStartlab.mas_bottom).mas_offset(Kmargin);
        }];
        _voteTimeLab = timeVotelab;

        //投票规则
        HLHJVoteRuleView *votRule = [HLHJVoteRuleView new];
        votRule.titleLab.text = @"报名规则";
        [self addSubview:votRule];
        [votRule mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self);
            make.top.equalTo(timeVotelab.mas_bottom).mas_offset(Kmargin * 3 );
        }];
        _votRule = votRule;
        
        _isChoooseImg = NO;
        
    }
    return self;
    
}
- (void)setModel:(HLHJVoteActivityDetilModel *)model {
    _model = model;
    _votRule.ruleArray = model.enroll_rule;
}
- (void)setContentUI {

    self.bgView  = [UIView new];
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.bgView.layer.cornerRadius = 8;
    self.bgView.clipsToBounds = YES;
    [self addSubview:self.bgView];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).mas_offset(Kmargin);
        make.right.equalTo(self).mas_offset(-Kmargin);
        make.height.mas_equalTo(410);
    }];
    
    ///我要报名
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.text = @"我要报名";
    
    titleLab.font = [UIFont boldSystemFontOfSize:17];
    
    if([GetDefaults isEqualToString:@"red"]){
        titleLab.textColor = [UIColor redColor];
    }else {
        titleLab.textColor = [UIColor colorWithRed:51.9996/255.0 green:125.001/255.0 blue:223.997/255.0 alpha:1];
    }
    
    [self.bgView addSubview:titleLab];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgView);
        make.top.equalTo(self.bgView).mas_offset(Kmargin + 5);
    }];
    
    UIImageView *leftImg = [UIImageView new];
    leftImg.image = [UIImage imageNamed:@"HLHJVoteResource.bundle/nav_left"];
    [self.bgView addSubview:leftImg];
    
    UIImageView *rightImg = [UIImageView new];
    rightImg.image = [UIImage imageNamed:@"HLHJVoteResource.bundle/nav_right"];
    [self.bgView addSubview:rightImg];
    
    [leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLab);
        make.right.equalTo(titleLab.mas_left).mas_offset(-Kmargin);
    }];
    [rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLab);
        make.left.equalTo(titleLab.mas_right).mas_offset(Kmargin);
    }];
    
    
    ///姓名
    UILabel *nameLab = [[UILabel alloc] init];
    nameLab.text = @"姓名";
    nameLab.font = [UIFont systemFontOfSize:14];
    nameLab.textColor = [UIColor colorWithRed:101.997/255.0 green:101.997/255.0 blue:101.997/255.0 alpha:1];
    [self.bgView  addSubview:nameLab];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).mas_offset(Kmargin);
        make.top.equalTo(titleLab.mas_bottom).mas_offset(Kmargin*2);
    }];
    
    UITextField *nameFiled = [UITextField new];
    nameFiled.textColor = [UIColor blackColor];
    nameFiled.font = [UIFont systemFontOfSize:14];
    nameFiled.backgroundColor = [UIColor colorWithRed:243.996/255.0 green:243.996/255.0 blue:243.996/255.0 alpha:1];
    nameFiled.placeholder = @"请输入姓名";
    [self.bgView  addSubview:nameFiled];
    self.nameFiled = nameFiled;
    [nameFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(nameLab);
        make.left.equalTo(nameLab.mas_right).mas_offset(Kmargin);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 20)];
    leftView.backgroundColor = [UIColor clearColor];
    nameFiled.leftView = leftView;
    nameFiled.leftViewMode  = UITextFieldViewModeAlways;
    
    ////电话
    UILabel *phoneLab = [[UILabel alloc] init];
    phoneLab.text = @"电话";
    phoneLab.font = [UIFont systemFontOfSize:14];
    phoneLab.textColor = [UIColor colorWithRed:101.997/255.0 green:101.997/255.0 blue:101.997/255.0 alpha:1];
    [self.bgView  addSubview:phoneLab];
    
    
    UITextField *phoneFiled = [UITextField new];
    phoneFiled.textColor = [UIColor blackColor];
    phoneFiled.font = [UIFont systemFontOfSize:14];
    phoneFiled.backgroundColor = [UIColor colorWithRed:243.996/255.0 green:243.996/255.0 blue:243.996/255.0 alpha:1];
    phoneFiled.placeholder = @"请输入电话";
    phoneFiled.keyboardType = UIKeyboardTypePhonePad;
    [self.bgView  addSubview:phoneFiled];
    self.phoneFiled = phoneFiled;
    UIView *leftView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 20)];
    leftView1.backgroundColor = [UIColor clearColor];
    phoneFiled.leftView = leftView1;
    phoneFiled.leftViewMode  = UITextFieldViewModeAlways;
    
    [phoneFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(nameLab);
        make.right.equalTo(self.bgView.mas_right).mas_offset(-Kmargin);
        make.width.height.equalTo(nameFiled);
    }];
    
    [phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(nameLab);
        make.right.equalTo(phoneFiled.mas_left).mas_offset(-Kmargin);
    }];

    ///个人简介
    UILabel *pLab = [[UILabel alloc] init];
    pLab.text = @"个人\n简介";
    pLab.numberOfLines = 0;
    pLab.font = [UIFont systemFontOfSize:14];
    pLab.textColor = [UIColor colorWithRed:101.997/255.0 green:101.997/255.0 blue:101.997/255.0 alpha:1];
    [self.bgView  addSubview:pLab];
    
    UITextView *desTextView = [[UITextView alloc]init];
    desTextView.backgroundColor = [UIColor colorWithRed:243.996/255.0 green:243.996/255.0 blue:243.996/255.0 alpha:1];
    desTextView.textColor = [UIColor blackColor];
    desTextView.font = [UIFont systemFontOfSize:14];
    [self.bgView  addSubview:desTextView];
    self.desTextView = desTextView;
    
    [desTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneFiled.mas_bottom).mas_offset(Kmargin);
        make.right.equalTo(phoneFiled.mas_right);
        make.left.equalTo(nameFiled.mas_left);
        make.height.mas_equalTo(100);
    }];
    
    [pLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(desTextView);
        make.left.equalTo(nameLab.mas_left);
        make.right.equalTo(nameLab.mas_right);
    }];
    
    ///上传照片
    UILabel *scLab = [[UILabel alloc] init];
    scLab.text = @"上传\n照片";
    scLab.numberOfLines = 0;
    scLab.font = [UIFont systemFontOfSize:14];
    scLab.textColor = [UIColor colorWithRed:101.997/255.0 green:101.997/255.0 blue:101.997/255.0 alpha:1];
    [self.bgView  addSubview:scLab];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor =  [UIColor colorWithRed:243.996/255.0 green:243.996/255.0 blue:243.996/255.0 alpha:1];
    [btn addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"HLHJVoteResource.bundle/ic_bm_xiangji"] forState:UIControlStateNormal];
    [self.bgView  addSubview:btn];
    self.sctpBtn = btn;
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        make.left.equalTo(desTextView.mas_left);
        make.top.equalTo(desTextView.mas_bottom).mas_offset(Kmargin);
    }];
    
    [scLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btn);
        make.left.equalTo(nameLab.mas_left);
        make.right.equalTo(nameLab.mas_right);
    }];
    

    ///删除按钮
    UIButton *delbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [delbtn setImage:[UIImage imageNamed:@"HLHJVoteResource.bundle/ic_del"] forState:UIControlStateNormal];
    delbtn.hidden = YES;
    [delbtn addTarget:self action:@selector(delBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.sctpBtn  addSubview:delbtn];
    [delbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.sctpBtn).mas_offset(5);
        make.top.equalTo(self.sctpBtn).mas_offset(-5);
    }];
    self.delBtn = delbtn;

    
    ///上传按钮
    UIButton *scbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if ([GetDefaults isEqualToString:@"red"]) {
         [scbtn setBackgroundImage:[UIImage imageNamed:@"HLHJVoteResource.bundle/btn_tijiao_red"] forState:UIControlStateNormal];
    }else {
         [scbtn setBackgroundImage:[UIImage imageNamed:@"HLHJVoteResource.bundle/Btn_tijiao"] forState:UIControlStateNormal];
    }
  
    [scbtn setTitle:@"提交" forState:UIControlStateNormal];
    [scbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [scbtn addTarget:self action:@selector(tijiaoAction:) forControlEvents:UIControlEventTouchUpInside];
    scbtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.bgView  addSubview:scbtn];
    
    [scbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgView );
        make.bottom.equalTo(self.bgView ).mas_offset(-Kmargin * 2.5);
    }];
    
}



#pragma UIActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0://照相机
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [[self currentViewController ] presentViewController:imagePicker animated:YES completion:nil];
            
        }
            break;
        case 1://本地相簿
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [[self currentViewController ] presentViewController:imagePicker animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
    
}
#pragma UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeImage]) {
        UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
        [self.sctpBtn setImage:img forState:UIControlStateNormal];
        self.delBtn.hidden = NO;
        _isChoooseImg = YES;
    }
     [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];

}

- (void)delBtnAction:(UIButton *)sender {
    
    [self.sctpBtn setImage:[UIImage imageNamed:@"HLHJVoteResource.bundle/ic_bm_xiangji"] forState:UIControlStateNormal];
     self.delBtn.hidden = YES;
     _isChoooseImg = NO;
    
}
- (void)chooseAction:(UIButton *)sender {
    
    [_phoneFiled resignFirstResponder];
    [_nameFiled resignFirstResponder];
    [_desTextView resignFirstResponder];
    
    UIActionSheet* actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"请选择图片"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"相机",@"相册",nil];
    [actionSheet showInView:self];
    
    
}

- (void)tijiaoAction:(UIButton *)sender {
    
    [_phoneFiled resignFirstResponder];
    [_nameFiled resignFirstResponder];
    [_desTextView resignFirstResponder];
    if (self.nameFiled.text.length == 0) {
        [HLHJVoteToast hsShowBottomWithText:@"请输入姓名"];
        return;
    }
    if (![NSString phoneMenberRule:self.phoneFiled.text]) {
        [HLHJVoteToast hsShowBottomWithText:@"请输入正确的电话号码"];
        return;
    }
    if (self.desTextView.text.length == 0) {
        [HLHJVoteToast hsShowBottomWithText:@"请输入简介"];
        return;
    }
    if (!_isChoooseImg) {
        [HLHJVoteToast hsShowBottomWithText:@"请上传图片"];
        return;
    }
    
    NSDictionary *prama = @{@"user_id":_model.user.user_id,
                            @"competitor_name":_nameFiled.text,
                            @"phone":_phoneFiled.text,
                            @"profile":_desTextView.text,
                            @"activity_id":_model.activity_id,
                            };
    //UIImage转换为NSData
    NSData *imageData = UIImageJPEGRepresentation(self.sctpBtn.currentImage, 1.0f);
    if (self.tiJiaoBlock) {
        self.tiJiaoBlock(prama,imageData);
    }
    
}

- (UIViewController *)currentViewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
@end
