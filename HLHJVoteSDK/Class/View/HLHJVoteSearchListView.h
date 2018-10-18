//
//  HLHJVoteSearchListView.h
//  HLHJVoteSDK
//
//  Created by mac on 2018/8/8.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ClickCancelBlock)(NSInteger chooseIndex);
/**
 搜索下拉列表
 */
@interface HLHJVoteSearchListView : UIView

@property (nonatomic, copy) ClickCancelBlock clickCancelBlock;


@property (nonatomic, strong) NSMutableArray  *screeingArr;

-(instancetype)initWithFrame:(CGRect)frame;


- (void)showView;

-(void)dismissAlertView;

@end
