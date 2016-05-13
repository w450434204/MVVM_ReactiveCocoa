//
//  LoginViewMode.h
//  MVVM_ReactiveCocoa登陆界面
//
//  Created by bwu on 16/5/12.
//  Copyright © 2016年 wubiao. All rights reserved.
// 登陆视图模型

#import <Foundation/Foundation.h>

#import <ReactiveCocoa/RACReturnSignal.h>
#import "ReactiveCocoa.h"
#import "Account.h"






@interface LoginViewMode : NSObject

@property (nonatomic, retain) Account *account;

@property(nonatomic,strong,readonly) RACSignal *enableLoginSignal;

@property(nonatomic,strong,readonly) RACCommand *LoginCommand;
@end
