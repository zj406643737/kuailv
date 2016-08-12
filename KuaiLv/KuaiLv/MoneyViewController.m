//
//  MoneyViewController.m
//  KuaiLv
//
//  Created by GH on 16/8/4.
//  Copyright © 2016年 GH. All rights reserved.
//

#import "MoneyViewController.h"


#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height

@interface MoneyViewController ()

@end

@implementation MoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    
    
    [self createView];
    [self createButton];
}


- (void)createButton {

    NSArray *array = @[@"消费记录",@"充值记录",@"退款记录"];
    
    for (int i = 0; i < 3; i ++) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:button];
        button.frame = CGRectMake(WIDTH / 8 + i * (WIDTH / 4 + 2) - 2 , 64 +30, WIDTH / 4, 40);
        button.backgroundColor = [UIColor colorWithWhite:0.591 alpha:1.000];
        [button setTitle:array[i] forState:UIControlStateNormal];
        
    }



}


- (void)createView {

    
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
    label.text = @"交易明细";
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
