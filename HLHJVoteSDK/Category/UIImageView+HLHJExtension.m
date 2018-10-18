//
//  UIImage+HLHJExtension.m
//  HLHJVoteSDK
//
//  Created by mac on 2018/8/16.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "UIImage+HLHJExtension.h"
#import "UIImageView+WebCache.h"
#import "UIImage+HLHJExtension.h"
@implementation UIImageView (HLHJExtension)
/**
 *  圆形
 */
- (void)hlhj_setCircleHeaderWithUrl:(NSString *)url placeholder:(NSString *)placeholderName {
    
    // 让占位图片也是圆的
    UIImage *placeholderImage = [UIImage hlhj_circleImage:placeholderName];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

        if (image == nil) return;

        self.image = [image hlhj_circleImage];
    }];

    
}

/**
 *  方形或者圆角型
 */
- (void)hlhj_setRectHeaderWithUrl:(NSString *)url placeholder:(NSString *)placeholderName{
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:placeholderName] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (image == nil) return;
        
        self.layer.cornerRadius = 8.0;
        self.clipsToBounds = YES;
    }];
    
}

/**
 *  菱形
 */
- (void)hlhj_setSixSideHeaderWithUrl:(NSString *)url placeholder:(NSString *)placeholderName{
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:placeholderName] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (image == nil) return;
        
        // 这个宽高要跟外面你要设置的 imageview 的宽高一样
        CGFloat imageViewW = 109;
        CGFloat imageViewH = 68;
        
        UIBezierPath * path = [UIBezierPath bezierPath];
        path.lineWidth = 2;
        [path moveToPoint:CGPointMake(8, 0)];//设置起始点
        [path addLineToPoint:CGPointMake(imageViewW, 0)];//途经点
        [path addLineToPoint:CGPointMake(imageViewW-8, imageViewH)];//途经点
        [path addLineToPoint:CGPointMake(0, imageViewH)];//途经点
        [path closePath];
        CAShapeLayer * shapLayer = [CAShapeLayer layer];
        shapLayer.lineWidth = 2;
        shapLayer.path = path.CGPath;
        self.layer.mask = shapLayer;
    }];
    
    
}



@end
