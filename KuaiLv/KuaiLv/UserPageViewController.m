//
//  UserPageViewController.m
//  KuaiLv
//
//  Created by GH on 16/8/2.
//  Copyright © 2016年 GH. All rights reserved.
//

#import "UserPageViewController.h"
#import "SignPageViewController.h"
#import "ForgetPageViewController.h"
#import "quickSignViewController.h"
#import <MBProgressHUD.h>

#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height

@interface UserPageViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *userTextField;
@property (nonatomic, strong) UITextField *passTextField;
@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation UserPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.817 alpha:1.000];
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithTitle:@"快捷登录" style:UIBarButtonItemStylePlain target:self action:@selector(quickSignIn)];
    self.navigationItem.rightBarButtonItems =@[item];

    //textfieldView
    UIView *viewOfTextField = [[UIView alloc] initWithFrame:CGRectMake(10, 64 + 20, self.view.frame.size.width - 20, self.view.frame.size.height / 6)];
    [self.view addSubview:viewOfTextField];
    viewOfTextField.backgroundColor = [UIColor whiteColor];
    viewOfTextField.layer.cornerRadius = 5;
    
    //textfield
    
    self.userTextField = [[UITextField alloc] initWithFrame:CGRectMake(10 + 5 + 30 + 5, 10 + 64 + 20 , viewOfTextField.frame.size.width - 60, viewOfTextField.frame.size.height / 2 - 10)];
    [self.view addSubview:self.userTextField];
    self.userTextField.backgroundColor = [UIColor whiteColor];
    self.userTextField.placeholder = @"请输入手机号";
    self.userTextField.delegate = self;
    self.userTextField.returnKeyType = UIReturnKeyDone;
    
    //imageuser
    UIImageView *imageViewOfUser = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    imageViewOfUser.frame = CGRectMake(15,self.userTextField.center.y - 15, 30, 30);
    [self.view addSubview:imageViewOfUser];
    imageViewOfUser.backgroundColor = [UIColor grayColor];
    
    //textfieldPass
    self.passTextField = [[UITextField alloc] initWithFrame:CGRectMake(45 + 10, 10 + 64 + 20 + viewOfTextField.frame.size.height / 2 - 10 + 5 , viewOfTextField.frame.size.width - 60, viewOfTextField.frame.size.height / 2 - 10)];
    [self.view addSubview:self.passTextField];
    self.passTextField.backgroundColor = [UIColor whiteColor];
    self.passTextField.placeholder = @"请输入密码";
    self.passTextField.delegate = self;
    self.passTextField.returnKeyType = UIReturnKeyDone;

    
    //imagePassWord
    UIImageView *imageViewPass = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    [self.view addSubview:imageViewPass];
    imageViewPass.frame = CGRectMake(15,self.passTextField.center.y - 15, 30, 30);
    imageViewPass.backgroundColor = [UIColor grayColor];
    //登录
    
    UIButton *buttonSign = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:buttonSign];
    buttonSign.frame = CGRectMake(10, 64 + 20 + self.view.frame.size.height / 6 + 30, self.view.frame.size.width - 20, viewOfTextField.frame.size.height / 2 - 10);
    buttonSign.backgroundColor = [UIColor grayColor];
    [buttonSign setTitle:@"登  录" forState:UIControlStateNormal];
    buttonSign.titleLabel.font = [UIFont systemFontOfSize:22];
    [buttonSign addTarget:self action:@selector(signInbutton) forControlEvents:UIControlEventTouchUpInside];
    
    //忘记密码
    UIButton *buttonForget = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:buttonForget];
    buttonForget.frame = CGRectMake(10, 64 + 10 + 30 +self.view.frame.size.height / 6 + viewOfTextField.frame.size.height / 2 - 10 + 20, self.view.frame.size.width / 4 + 10, 20);
    [buttonForget setTitle:@"忘记密码?" forState:UIControlStateNormal];
    
    [buttonForget addTarget:self action:@selector(forgetPage) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonRegister = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:buttonRegister];
    buttonRegister.frame = CGRectMake(self.view.frame.size.width - 10 -self.view.frame.size.width / 4, 64 + 10 + 30 +self.view.frame.size.height / 6 + viewOfTextField.frame.size.height / 2 - 10 + 20, self.view.frame.size.width / 4, 20);
    [buttonRegister setTitle:@"立即注册" forState:UIControlStateNormal];
    
    [buttonRegister addTarget:self action:@selector(registerPage) forControlEvents:UIControlEventTouchUpInside];

}


- (void)signInbutton {

    if ([self.userTextField.text isEqualToString:@""]) {
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        self.hud.mode = MBProgressHUDModeText;
        self.hud.labelText = @"请输入手机号";
        self.hud.removeFromSuperViewOnHide = YES;
        [self.hud hide:YES afterDelay:1.5];
    } else if ([self.passTextField.text isEqualToString:@""]) {
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.hud.mode = MBProgressHUDModeText;
        self.hud.labelText = @"请输入密码";
        self.hud.removeFromSuperViewOnHide = YES;
        [self.hud hide:YES afterDelay:1.5];
    
    }else {
        [self sessionPostRequest];
       
    }
    
    /**
     *  @author GH, 16-08-11 11:08:21
     *
     *       self.hud.mode = MBProgressHUDModeText;
     self.hud.removeFromSuperViewOnHide = YES;
     [self.hud hide:YES afterDelay:1.5];
     [self performSelector:@selector(delayMethod) withObject:nil afterDelay:1.5f];
     
                   hud.labelText = @"登录成功";
     
     *
     *  @return
     */
}

- (void)delayMethod {
    
    [self.navigationController popViewControllerAnimated:YES];


}


- (void)quickSignIn {

    quickSignViewController *quickVc = [[quickSignViewController alloc] init];
    
    [self.navigationController pushViewController:quickVc animated:YES];
}


- (void)forgetPage {

    ForgetPageViewController *forgetPage = [[ForgetPageViewController alloc] init];

    [self.navigationController pushViewController:forgetPage animated:YES];

}



- (void)sessionPostRequest {
    //@"login_phone=1234&&login_password=POST5678";
    // 1.获取url
    NSString *urlStr = @"http://114.215.128.252:1919/APP/AndroidClient/MemberLogon.ashx";
    NSURL *url = [NSURL URLWithString:urlStr];
    // 2.创建session对象
    NSURLSession *session = [NSURLSession sharedSession];
    // 3.创建请求对象
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    // 4.设置请求方式与参数
    request.HTTPMethod = @"POST";
    // 1.获取url

    NSString *newStr = [NSString stringWithFormat:@"login_phone=%@&&login_password=%@",self.userTextField.text,self.passTextField.text];
    NSLog(@"   %@",newStr);
    
    NSString *josnSting = [newStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSData *data = [josnSting dataUsingEncoding:NSUTF8StringEncoding];
    
    //HTTPBody
    request.HTTPBody = data;
    
    // 5.进行链接请求数据
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                NSLog(@"请求数据出错!----%@",error.description);
            } else {
                NSLog(@"请求数据成功!");
                NSDictionary *content = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];//转换数据格式
                if ([[content objectForKey:@"result"] isEqualToString:@"ok"]) {
                    NSLog(@"登录成功");
                    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    self.hud.mode = MBProgressHUDModeText;
                    self.hud.removeFromSuperViewOnHide = YES;
                    [self.hud hide:YES afterDelay:1.5];
                    self.hud.labelText = @"登录成功";
                    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:1.5f];
                    
                    //延迟推出页面
                }else {
                    NSLog(@"登录失败");
                    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    self.hud.mode = MBProgressHUDModeText;
                    self.hud.removeFromSuperViewOnHide = YES;
                    [self.hud hide:YES afterDelay:1.5];
                    self.hud.labelText = @"用户名或密码不正确";
                    
                }
                
                
            }
        });
    }];
    // 6.开启请求数据
    [dataTask resume];
    NSLog(@"session post request!");
}


- (void)registerPage {
    SignPageViewController *sign = [[SignPageViewController alloc] init];
    [self.navigationController pushViewController:sign animated:YES];
}


- (void)disMissVC {
[self dismissViewControllerAnimated:YES completion:^{
}];
}
-(BOOL) textFieldShouldBeginEditing:(UITextField *)textField{
    if (!textField.window.isKeyWindow) {
        [textField.window makeKeyAndVisible];
    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [textField becomeFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
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
