//
//  UIImage+HLHJExtension.h
//  HLHJVoteSDK
//
//  Created by mac on 2018/8/16.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (HLHJExtension)

/**
 *  圆形
 */
- (void)hlhj_setCircleHeaderWithUrl:(NSString *)url placeholder:(NSString *)placeholderName;

/**
 *  方形或者圆角型
 */
- (void)hlhj_setRectHeaderWithUrl:(NSString *)url placeholder:(NSString *)placeholderName;

/**
 *  菱形
 */
- (void)hlhj_setSixSideHeaderWithUrl:(NSString *)url placeholder:(NSString *)placeholderName;


@end
