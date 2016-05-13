//
//  LoginViewMode.m
//  MVVM_ReactiveCocoa登陆界面
//
//  Created by bwu on 16/5/12.
//  Copyright © 2016年 wubiao. All rights reserved.
//

#import "LoginViewMode.h"
 
#import "MBProgressHUD.h"
 

@implementation LoginViewMode

-(instancetype)init
{
    if (self = [super init]) {
        [self setUp];
    }
    
    return self;
}

-(Account *)account
{
    if (_account == nil) {
        _account  = [[Account alloc ] init];
    }
    
    return _account;
}


-(void)setUp
{
    //利用先聚合在组合的思想
    //RACObserve()这个宏是监听某个对象的某个属性 返回的是信号
    _enableLoginSignal  = [RACSignal combineLatest:@[RACObserve(self.account, account),RACObserve(self.account, pwd)] reduce:^id(NSString* account111, NSString* pwd222){
        
        return @(account111.length && pwd222.length);
    }];
    
    
    
    //RACCommand命令处理登陆业务逻辑
    _LoginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"点击了登陆按钮");
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            //模仿网络延迟
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [subscriber sendNext:@"登陆成功"];
                [subscriber sendCompleted];
            });
            return nil;
        }];
    }];
  
    
    
    //获取执行命令所返回的数据
    [_LoginCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        if ([x isEqualToString:@"登陆成功"]) {
            NSLog(@"登陆成功");
        }
    }];
    
    
    //监听登陆状态
    [[_LoginCommand.executing skip:1] subscribeNext:^(id x) {
        if([x boolValue] == YES ){
             //显示蒙板
            [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].windows lastObject] animated:YES];
            
        } else {
            
            //蒙板消失
            [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication].windows lastObject] animated:YES];
        }
    }];
    
    
    
}


@end
