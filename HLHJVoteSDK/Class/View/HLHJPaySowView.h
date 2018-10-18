//
//  HLHJPaySowView.h
//  HLHJVoteSDK
//
//  Created by mac on 2018/8/7.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CancelBlock)(void);

@interface HLHJPaySowView : UIView

@property (nonatomic, copy) CancelBlock block;

-(instancetype)initWithDateSource:(id)data;

- (void)showPayView;

-(void)hidenView;

@end
