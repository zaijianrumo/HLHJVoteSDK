//
//  HLHJVotePayController.h
//  HLHJVoteSDK
//
//  Created by mac on 2018/8/7.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>



/**
 投票支付
 */
@interface HLHJVotePayController : HLHJBaseController

@property (nonatomic, copy) NSString  *entry_fee;

@property (nonatomic, strong) NSDictionary  *prama;

@property (nonatomic, strong) NSData *imgageData;

@end
