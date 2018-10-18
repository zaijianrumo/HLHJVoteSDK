//
//  HLHJSingupSuccesView.h
//  HLHJVoteSDK
//
//  Created by mac on 2018/8/22.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CancelBlock)(void);

@interface HLHJSingupSuccesView : UIView

@property (nonatomic, copy) CancelBlock  cancelBlock;

- (void)showView;

-(void)dismissAlertView;

@end
