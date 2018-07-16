//
//  User.h
//  MyRealmDemo
//
//  Created by 蔡成汉 on 2018/7/16.
//  Copyright © 2018年 蔡成汉. All rights reserved.
//

#import "BaseModel.h"

typedef NS_ENUM(NSInteger, UserLine) {
    LineOne = 0,
    LineTwo,
    LineThree,
    LineFour,
    LineFive
};

@interface User : BaseModel

@property NSString *name;

@property NSInteger uid;

@property UserLine line;

@property BOOL online;

@end
