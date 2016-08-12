//
//  AboutUsViewController.m
//  KuaiLv
//
//  Created by GH on 16/8/5.
//  Copyright © 2016年 GH. All rights reserved.
//

#import "AboutUsViewController.h"

#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createView];
    [self createLogo];
}



- (void)createLogo {


    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    [self.view addSubview:imageView];
    
    imageView.frame = CGRectMake(WIDTH / 5, 64 + HEIGHT / 8, WIDTH * 3 / 5, HEIGHT / 5);
    imageView.backgroundColor = [UIColor whiteColor];
    
    UILabel *labelLogo = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x - 50,  64 + HEIGHT / 8 + HEIGHT / 5 + 20, 100, 30)];
    [self.view addSubview:labelLogo];
    labelLogo.text = @"快驴  v1.0.0";
    labelLogo.textAlignment = 1;
    

    
    //label
    
    UILabel *labelPhone = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH / 2 - 100, HEIGHT / 7 * 6, WIDTH / 3, 30)];
    [self.view addSubview:labelPhone];
    labelPhone.text = @"客服电话 :";
    
    //button
    
    UIButton *buttonPhone = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:buttonPhone];
    buttonPhone.frame = CGRectMake(WIDTH / 2 - 50, HEIGHT / 7 * 6, WIDTH / 2, 30);
    [buttonPhone setTitle:@"00000000000" forState:UIControlStateNormal];

    [buttonPhone setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}


- (void)createView {
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
    label.text = @"关于我们";
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
