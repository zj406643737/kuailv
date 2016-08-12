//
//  quickSignViewController.m
//  KuaiLv
//
//  Created by GH on 16/8/9.
//  Copyright © 2016年 GH. All rights reserved.
//

#import "quickSignViewController.h"
#import "UserPageViewController.h"
#import <MBProgressHUD.h>

#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height

@interface quickSignViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *phoneTextfield;
@property (nonatomic, strong) UITextField *textFieldVer;
@property (nonatomic, strong) UserPageViewController *userVc;

@end

@implementation quickSignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.843 alpha:1.000];
    [self createTextfield];
    
}

- (void)createTextfield {
    
    //phoneNumber
    
    self.phoneTextfield = [[UITextField alloc] initWithFrame:CGRectMake(10, 64 + 20,WIDTH - 20, HEIGHT / 15)];
    [self.view addSubview:self.phoneTextfield];
    self.phoneTextfield.backgroundColor = [UIColor whiteColor];
    self.phoneTextfield.placeholder = @"请输入手机号";
    self.phoneTextfield.layer.cornerRadius = 5;
    self.phoneTextfield.delegate = self;
    self.phoneTextfield.returnKeyType = UIReturnKeyDone;

    
    
    //验证码button
    UIButton *buttonVer = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonVer.frame = CGRectMake(10 + WIDTH / 5 * 3 + 10,  64 + 20 + HEIGHT / 15 + 10, WIDTH / 5 * 2 - 30, HEIGHT / 15);
    [self.view addSubview:buttonVer];
    buttonVer.backgroundColor = [UIColor colorWithRed:0.318 green:0.293 blue:1.000 alpha:1.000];
    [buttonVer setTitle:@"发送验证码" forState:UIControlStateNormal];
    buttonVer.layer.cornerRadius = 5;
    
    //验证码textfield
    
    self.textFieldVer = [[UITextField alloc] initWithFrame:CGRectMake(10, 64 + 20 + HEIGHT / 15 + 10, WIDTH / 5 * 3 , HEIGHT / 15)];
    [self.view addSubview:self.textFieldVer];
    self.textFieldVer.layer.cornerRadius = 5;
    self.textFieldVer.backgroundColor = [UIColor whiteColor];
    self.textFieldVer.placeholder = @"请输入验证码";
    self.textFieldVer.delegate = self;
    self.textFieldVer.returnKeyType = UIReturnKeyDone;

    
    //UIbuttonSign
    
    UIButton *buttonSign = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonSign.frame = CGRectMake(10, 64 + 20 + HEIGHT / 15 * 2 + 20 + 30, WIDTH - 20, HEIGHT / 15);
    [self.view addSubview:buttonSign];
    buttonSign.backgroundColor =  [UIColor colorWithRed:0.318 green:0.293 blue:1.000 alpha:1.000];
    
    [buttonSign setTitle:@"登录" forState:UIControlStateNormal];
    
    [buttonSign addTarget:self action:@selector(makeSureButton) forControlEvents:UIControlEventTouchUpInside];
}


- (void)makeSureButton {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"登录成功";
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.5];
    
    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:1.5f];
}

- (void)delayMethod {

    [[NSNotificationCenter defaultCenter] postNotificationName:@"SignSure" object:nil];
    
    [self.navigationController popToRootViewControllerAnimated:YES];


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
