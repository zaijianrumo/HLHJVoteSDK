//
//  HLHJSingupHeadView.m
//  HLHJVoteSDK
//
//  Created by mac on 2018/8/7.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "HLHJSingupHeadView.h"

@implementation HLHJSingupHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self == [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        if ([GetDefaults isEqualToString:@"red"]) {
           imageView.image = [UIImage imageNamed:@"HLHJVoteResource.bundle/img_def_red"];
        }else {
           imageView.image = [UIImage imageNamed:@"HLHJVoteResource.bundle/img_def"];
        }
        
        imageView.frame = CGRectMake((self.frame.size.width - 190)/2, 30,189.5,146);
        [self addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0,CGRectGetMaxY(imageView.frame)+20,self.frame.size.width,12);
        label.text = @"报名开始啦，抓紧时间报名咯~";
        label.font = [UIFont systemFontOfSize:13];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithRed:101.997/255.0 green:101.997/255.0 blue:101.997/255.0 alpha:1];
        [self addSubview:label];
        
    }
    return self;
}

@end
