//
//  SignPageViewController.m
//  KuaiLv
//
//  Created by GH on 16/8/3.
//  Copyright © 2016年 GH. All rights reserved.
//

#import "SignPageViewController.h"
#import <AFNetworking.h>
#import <MBProgressHUD.h>

#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height

@interface SignPageViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *phoneTextfield;
@property (nonatomic, strong) UITextField *textFieldVer;
@property (nonatomic, strong) UITextField *textFieldSign;

@end

@implementation SignPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createHeadView];
    [self createTextField];

//    http://114.215.128.252:1919/APP/AndroidClient/MemberRegistered.ashx?entity={"Accounts":"123","Password":"123qwe"}
    //entity={"Password":"liu","Accounts":"123"}
    
    //http://114.215.128.252:1919/APP/AndroidClient/MemberRegistered.ashx?entity={"Accounts":"123","Password":"123qwe"}
    //http://114.215.128.252:1919/APP/AndroidClient/MemberLogon.ashx?entity={"Accounts":"123","Password":"123qwe"}
}

- (void)sessionPostRequest {

    // 1.获取url
    NSString *urlStr = @"http://114.215.128.252:1919/APP/AndroidClient/MemberRegistered.ashx";
    NSURL *url = [NSURL URLWithString:urlStr];
    // 2.创建session对象
    NSURLSession *session = [NSURLSession sharedSession];
    // 3.创建请求对象
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    // 4.设置请求方式与参数
    request.HTTPMethod = @"POST";
    // 1.获取url
    NSDictionary *dic = @{@"Accounts":self.phoneTextfield.text,@"Password":self.textFieldSign.text};
    NSLog(@"dictionary  %@",dic);
    NSData *dataCeshi = [NSJSONSerialization dataWithJSONObject:dic options:kNilOptions error:nil];
    NSString *josnSting = [[NSString alloc] initWithData:dataCeshi encoding:NSUTF8StringEncoding];
    
    NSString *newStr = [NSString stringWithFormat:@"entity=%@",josnSting];
    josnSting = [newStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"--------------%@",josnSting);
    NSData *data = [josnSting dataUsingEncoding:NSUTF8StringEncoding];
    
    //HTTPBody
    request.HTTPBody = data;
    
    // 5.进行链接请求数据
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                NSLog(@"请求数据出错!----%@",error.description);
            } else {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];//转换数据格式
                NSDictionary *contect = [dic objectForKey:@"result"];
                NSLog(@"dic:%@",dic);
                if ([[contect objectForKey:@"Accounts"] isEqualToString:self.phoneTextfield.text]) {
                    NSLog(@"注册成功");
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"SignSure" object:nil userInfo:@{@"contect":contect}];
                    
                    NSLog(@"contect-----%@",contect);
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.labelText = @"注册成功";
                    hud.removeFromSuperViewOnHide = YES;
                    [hud hide:YES afterDelay:1.5];
//                     [self performSelector:@selector(delayMethod) withObject:nil afterDelay:1.5f];
                }else {
                    NSLog(@"注册失败");
                
                }
            }
        });
    }];
    // 6.开启请求数据
    [dataTask resume];
    NSLog(@"session post request!");
}





- (void)data {
// 1.获取url
    NSDictionary *dic = @{@"Accounts":@"12345678901",@"Password":@"liuweishu"};
    NSData *dataCeshi = [NSJSONSerialization dataWithJSONObject:dic options:kNilOptions error:nil];
    NSString *josnSting = [[NSString alloc] initWithData:dataCeshi encoding:NSUTF8StringEncoding];
    NSString *urlStr = [NSString stringWithFormat:@"http://114.215.128.252:1919/APP/AndroidClient/MemberRegistered.ashx?entity=%@",josnSting];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    }
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSString *result = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
                    NSLog(@"%@",result);
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             NSLog(@"%@",error);  //这里打印错误信息
         }];
}




- (void)createTextField {
    
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

    
    
    
    //登录textfield
    
    
    self.textFieldSign = [[UITextField alloc] initWithFrame:CGRectMake(10, 64 + 20 + HEIGHT / 15 * 2 + 20, WIDTH - 20, HEIGHT / 15)];
    [self.view addSubview:self.textFieldSign];
    self.textFieldSign.layer.cornerRadius = 5;
    self.textFieldSign.backgroundColor = [UIColor whiteColor];
    self.textFieldSign.placeholder = @"登录密码";
    self.textFieldSign.delegate = self;
    self.textFieldSign.secureTextEntry = YES;
    self.textFieldSign.returnKeyType = UIReturnKeyDone;

    
    
    //UIbuttonSign
    
    UIButton *buttonSign = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonSign.frame = CGRectMake(10, 64 + 20 + HEIGHT / 15 * 3 + 20 + 40, WIDTH - 20, HEIGHT / 15);
    [self.view addSubview:buttonSign];
    buttonSign.backgroundColor =  [UIColor colorWithRed:0.318 green:0.293 blue:1.000 alpha:1.000];
    
    [buttonSign setTitle:@"注册" forState:UIControlStateNormal];
    
    [buttonSign addTarget:self action:@selector(signInButton) forControlEvents:UIControlEventTouchUpInside];

}




- (void)signInButton {

    
    
  if ([self.phoneTextfield.text isEqualToString:@""]) {
      MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
      hud.mode = MBProgressHUDModeText;
      hud.labelText = @"请输入手机号";
      hud.removeFromSuperViewOnHide = YES;
      [hud hide:YES afterDelay:1.5];
      
  } else if (self.phoneTextfield.text.length < 11) {
      MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
      hud.mode = MBProgressHUDModeText;
      hud.labelText = @"请输入正确手机号";
      hud.removeFromSuperViewOnHide = YES;
      [hud hide:YES afterDelay:1.5];
  
  } else if ([self.textFieldSign.text isEqualToString:@""]) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请输入密码";
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1.5];
    
  }else if (self.textFieldSign.text.length < 6) {
      MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
      hud.mode = MBProgressHUDModeText;
      hud.labelText = @"密码不能少于6位";
      hud.removeFromSuperViewOnHide = YES;
      [hud hide:YES afterDelay:1.5];

  } else {
        [self sessionPostRequest];
    }
}

- (void)delayMethod {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SignSure" object:nil userInfo:@{@"key":self.phoneTextfield.text}];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [textField becomeFirstResponder];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [textField resignFirstResponder];

    return YES;
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
    label.text = @"注册";
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


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == self.phoneTextfield) {
        return [self validateNumber:string];
    }
    
    return YES;
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
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
