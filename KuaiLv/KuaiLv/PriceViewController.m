//
//  PriceViewController.m
//  KuaiLv
//
//  Created by GH on 16/8/4.
//  Copyright © 2016年 GH. All rights reserved.
//

#import "PriceViewController.h"

@interface PriceViewController ()

@end

@implementation PriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    [self createView];
    [self createForm];
}

- (void)createForm {

    UIView *viewForm = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + 20, self.view.frame.size.width, self.view.frame.size.height / 2)];
    viewForm.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:viewForm];
    
    NSArray *arrCon = @[@"5公里以内 5公斤以下",@"超过5公里, 每增加5公里",@"超过20公里, 每增加5公里",@"超过5公斤, 每增加一公斤",@"超过20公斤, 每增加1公斤"];
    NSArray *arrText = @[@"16元",@"增加8元",@"增加10元",@"增加2元",@"增加5元"];
    
    for (int i = 0; i < 5; i ++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10 , 10 + (viewForm.frame.size.height / 8 + 20) * i, viewForm.frame.size.width / 3 * 2, viewForm.frame.size.height / 8)];
        [viewForm addSubview:label];
        label.text = arrCon[i];
    }
    
    for (int i = 0; i < 5; i ++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(viewForm.frame.size.width / 3 * 2, 10 + (viewForm.frame.size.height / 8 + 20) * i, viewForm.frame.size.width / 3  - 20, viewForm.frame.size.height / 8)];
        [viewForm addSubview:label];
        label.text = arrText[i];
        label.textAlignment = 2;
        label.textColor = [UIColor orangeColor];
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
    label.text = @"价格表";
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
