//
//  HLHJSeeDetilView.h
//  HLHJVoteSDK
//
//  Created by mac on 2018/8/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef void (^CancelBlock)(void);

typedef void(^ChoosePersonBlock)(id data);
/**
 查看详情
 */
@interface HLHJSeeDetilView : UIView

//排名
@property (nonatomic, assign) NSInteger  No;

@property (nonatomic, copy) CancelBlock block;

@property (nonatomic, copy) ChoosePersonBlock  personBlock;

-(instancetype)initWithDateSource:(id)data showVoteBtn:(BOOL )show;

- (void)showView;

-(void)dismissAlertView;

@end
