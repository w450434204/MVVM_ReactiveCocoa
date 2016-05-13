//
//  ViewController.m
//  MVVM_ReactiveCocoa登陆界面
//
//  Created by bwu on 16/5/12.
//  Copyright © 2016年 wubiao. All rights reserved.
//


#import "ViewController.h"
#import "LoginViewMode.h"
#import "ReactiveCocoa.h"
#import <ReactiveCocoa/RACReturnSignal.h>

@interface ViewController ()
@property(nonatomic,strong) LoginViewMode *loginViewMode;
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation ViewController

-(LoginViewMode *)loginViewMode
{
    if (!_loginViewMode) {
        _loginViewMode = [[LoginViewMode alloc] init];
    }
    
    return  _loginViewMode;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    //给模型的属性绑定信号
    RAC(self.loginViewMode.account,account) = _accountField.rac_textSignal;
    RAC(self.loginViewMode.account,pwd) = _pwdField.rac_textSignal;
    
    
    //绑定登陆按钮
    RAC(self.loginBtn,enabled) = self.loginViewMode.enableLoginSignal;
    
    //监听登陆按钮点击
     [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
         [self.loginViewMode.LoginCommand execute:nil];
     }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
