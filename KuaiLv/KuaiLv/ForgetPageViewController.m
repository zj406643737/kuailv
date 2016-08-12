//
//  ForgetPageViewController.m
//  KuaiLv
//
//  Created by GH on 16/8/5.
//  Copyright © 2016年 GH. All rights reserved.


#import "ForgetPageViewController.h"

#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height

@interface ForgetPageViewController ()

@end

@implementation ForgetPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createHeadView];
    [self createTextField];
}





- (void)createTextField {
    
    //phoneNumber
    
    UITextField *phoneTextfield = [[UITextField alloc] initWithFrame:CGRectMake(10, 64 + 20,WIDTH / 5 * 3  , HEIGHT / 15)];
    [self.view addSubview:phoneTextfield];
    phoneTextfield.backgroundColor = [UIColor whiteColor];
    phoneTextfield.placeholder = @"请输入手机号";
    phoneTextfield.layer.cornerRadius = 5;
    
    //验证码button
    
    UIButton *buttonVer = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonVer.frame = CGRectMake(10 + WIDTH / 5 * 3 + 10, 64 + 20, WIDTH / 5 * 2 - 30, HEIGHT / 15);
    [self.view addSubview:buttonVer];
    buttonVer.backgroundColor = [UIColor colorWithRed:0.318 green:0.293 blue:1.000 alpha:1.000];
    [buttonVer setTitle:@"发送验证码" forState:UIControlStateNormal];
    buttonVer.layer.cornerRadius = 5;
    
    //验证码textfield
    
    UITextField *textFieldVer = [[UITextField alloc] initWithFrame:CGRectMake(10, 64 + 20 + HEIGHT / 15 + 10, WIDTH - 20, HEIGHT / 15)];
    [self.view addSubview:textFieldVer];
    textFieldVer.layer.cornerRadius = 5;
    textFieldVer.backgroundColor = [UIColor whiteColor];
    textFieldVer.placeholder = @"请输入验证码";
    
    
    //登录textfield
    
    
    UITextField *textFieldSign = [[UITextField alloc] initWithFrame:CGRectMake(10, 64 + 20 + HEIGHT / 15 * 2 + 20, WIDTH - 20, HEIGHT / 15)];
    [self.view addSubview:textFieldSign];
    textFieldSign.layer.cornerRadius = 5;
    textFieldSign.backgroundColor = [UIColor whiteColor];
    textFieldSign.placeholder = @"请输入新密码";
    
    //UIbuttonSign
    
    UIButton *buttonSign = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonSign.frame = CGRectMake(10, 64 + 20 + HEIGHT / 15 * 3 + 20 + 40, WIDTH - 20, HEIGHT / 15);
    [self.view addSubview:buttonSign];
    buttonSign.backgroundColor =  [UIColor colorWithRed:0.318 green:0.293 blue:1.000 alpha:1.000];
    
    [buttonSign setTitle:@"重置密码" forState:UIControlStateNormal];
    
    
}


- (void)createHeadView {
    self.view.backgroundColor = [UIColor grayColor];
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [self.view addSubview:view];
    view.backgroundColor = [UIColor blueColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button];
    button.frame = CGRectMake(10, view.center.y - 15, 30, 30);
    
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(disMissVC) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    //    label.backgroundColor = [UIColor orangeColor];
    label.center = view.center;
    label.text = @"重置密码";
    label.textAlignment = 1;
    label.font = [UIFont systemFontOfSize:17];
    [view addSubview:label];
    
}

- (void)disMissVC {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
