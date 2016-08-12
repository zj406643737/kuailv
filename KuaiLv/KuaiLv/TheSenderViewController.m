//
//  TheSenderViewController.m
//  KuaiLv
//
//  Created by GH on 16/8/5.
//  Copyright © 2016年 GH. All rights reserved.
//

#import "TheSenderViewController.h"
#import <MBProgressHUD.h>
#import "MapViewController.h"
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height

@interface TheSenderViewController ()<UITextFieldDelegate>

@end

@implementation TheSenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createHeadView];
    [self createSenderMassage];
}


- (void)createHeadView {
    self.view.backgroundColor = [UIColor colorWithWhite:0.768 alpha:1.000];
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [self.view addSubview:view];
    view.backgroundColor = [UIColor grayColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button];
    button.frame = CGRectMake(10, view.center.y - 15, 30, 30);
    
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(disMissVC) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    //    label.backgroundColor = [UIColor orangeColor];
    label.center = view.center;
    label.text = @"寄件人信息";
    label.textAlignment = 1;
    label.font = [UIFont systemFontOfSize:17];
    [view addSubview:label];
    
}


- (void)createSenderMassage {

    NSArray *arrayMessage = @[@"请输入寄件人姓名",@"请输入寄件人电话",@"请输入寄件人详细地址"];
    
    for (int i = 0; i < 3; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 66 + i * 52, WIDTH, 50)];
        [self.view addSubview:view];
        view.backgroundColor = [UIColor whiteColor];
        UITextField *fieldMessage = [[UITextField alloc] initWithFrame:CGRectMake(5, 70 + i * 52, WIDTH, 40)];
        [self.view addSubview:fieldMessage];
        fieldMessage.placeholder = arrayMessage[i];
        fieldMessage.tag = i + 10;
        fieldMessage.delegate = self;
        
        if (i ==2) {
            UIButton *mapbuuton = [UIButton buttonWithType:UIButtonTypeCustom];
            mapbuuton.frame = CGRectMake(WIDTH - 40, 5, 30, 30);
            [fieldMessage addSubview:mapbuuton];
            mapbuuton.backgroundColor = [UIColor redColor];
            [mapbuuton addTarget:self action:@selector(getmapVC) forControlEvents:UIControlEventTouchUpInside];
        
        }
    }
    
    UIButton *buttonMakeSure = [UIButton buttonWithType:UIButtonTypeCustom];
    
    buttonMakeSure.frame = CGRectMake(20, 66 + 3 * 52 + 50, WIDTH - 40, 40);
    [self.view addSubview:buttonMakeSure];
    [buttonMakeSure setTitle:@"确定" forState:UIControlStateNormal];
    buttonMakeSure.backgroundColor = [UIColor whiteColor];
    [buttonMakeSure setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    buttonMakeSure.layer.cornerRadius = 5;
    [buttonMakeSure addTarget:self action:@selector(makeSureMassage) forControlEvents:UIControlEventTouchUpInside];
}

-(void)getmapVC{
    
    
    NSLog(@"111");
    MapViewController *mapviewVC = [[MapViewController alloc]init];
    [self presentViewController:mapviewVC animated:YES completion:^{
        NSLog(@"222");
    }];
    
}

- (void)makeSureMassage {

    UITextField *textFieldSender = [self.view viewWithTag:10];
    UITextField *textFieldPhone  = [self.view viewWithTag:11];
    UITextField *textFieldAdress = [self.view viewWithTag:12];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    if ([textFieldSender.text isEqualToString:@""]) {
        
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请输入寄件人姓名";
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:2];

    } else if ([textFieldPhone.text isEqualToString:@""]) {
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请输入寄件人手机号";
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:2];
    } else if ([textFieldAdress.text isEqualToString:@""]) {
    
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请输入寄件人地址";
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:2];
        
    }else {
    
        [hud hide:YES];
        NSString *strMessage = [NSString stringWithFormat:@"%@ %@ %@",textFieldSender.text,textFieldPhone.text,textFieldAdress.text];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Sender" object:nil userInfo:@{@"key":strMessage}];
        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];

    }
}



- (void)disMissVC {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [textField becomeFirstResponder];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    UITextField *fieldPhone = [self.view viewWithTag:11];
    
    if (textField == fieldPhone) {
        return [self validateNumber:string];
    }
    return YES;
}

- (BOOL)validateNumber:(NSString *)number {
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
