//
//  UIImage+HLHJExtension.m
//  HLHJVoteSDK
//
//  Created by mac on 2018/8/16.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "UIImage+HLHJExtension.h"

@implementation UIImage (HLHJExtension)

- (instancetype)hlhj_circleImage {
    // 开启图形上下文
    UIGraphicsBeginImageContext(self.size);
    
    // 上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(context, rect);
    
    // 裁剪
    CGContextClip(context);
    
    // 绘制图片
    [self drawInRect:rect];
    
    // 获得图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
}

+ (instancetype)hlhj_circleImage:(NSString *)name {
    
    return [[self imageNamed:name] hlhj_circleImage];
}

@end
