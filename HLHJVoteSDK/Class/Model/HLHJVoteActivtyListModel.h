//
//  HLHJVoteActivtyListModel.h
//  HLHJVoteSDK
//
//  Created by mac on 2018/8/13.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLHJVoteActivtyListModel : NSObject
//"activity_id": 5,
//"title": "美女评选2",
//"activity_cover": "/application/hlhj_goddess_vote/upload/image/20180808/9c1c2faddb487f5f0f4af31ad8f07ff0.jpg",
//"enroll_start": "2018-08-01",
//"enroll_end": "2018-08-02",
//"start_time": "2018-08-03",
//"end_time": "2018-08-04",
//"entry_fee": "0.00",
//"enroll_check": 1,
//"state": "已结束"

@property (nonatomic, copy) NSString  *activity_id;
@property (nonatomic, copy) NSString  *title;
@property (nonatomic, copy) NSString  *activity_cover;
@property (nonatomic, copy) NSString  *enroll_start;
@property (nonatomic, copy) NSString  *enroll_end;
@property (nonatomic, copy) NSString  *start_time;
@property (nonatomic, copy) NSString  *end_time;
@property (nonatomic, copy) NSString  *entry_fee;
@property (nonatomic, copy) NSString  *enroll_check;
@property (nonatomic, assign) NSInteger  state;
@end
