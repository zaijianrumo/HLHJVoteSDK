//
//  NSString+HLHJExtention.h
//  HLHJVoteSDK
//
//  Created by mac on 2018/8/16.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HLHJExtention)

- (CGFloat)getHeightLineWithString:(NSString *)string withWidth:(CGFloat)width withFont:(UIFont *)font;

+ (BOOL)phoneMenberRule:(NSString *)phoneMenber;

@end
