//
//  LeftSortsViewController.m
//  LGDeckViewController
//
//  Created by jamie on 15/3/31.
//  Copyright (c) 2015年 GH. All rights reserved.
//


#import "LeftSortsViewController.h"
#import "AppDelegate.h"
#import "UserPageViewController.h"
#import "OrderViewController.h"
#import "MoneyViewController.h"
#import "PriceViewController.h"
#import "ComProblemViewController.h"
#import "AboutUsViewController.h"

#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height




@interface LeftSortsViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UIButton *buttonPhone;
@property (nonatomic, strong)NSDictionary *dicContext;


typedef NS_ENUM(char, iPhoneModel){  //0~3
    
        iPhone4,//320*480
        iPhone5,//320*568
        iPhone6,//375*667
        iPhone6Plus,//414*736
        UnKnown
};



@end

@implementation LeftSortsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor grayColor];
    
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height , self.view.frame.size.width, self.view.frame.size.height /2) style:UITableViewStylePlain];
   
    self.tableview.dataSource = self;
    self.tableview.delegate  = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableview];
    
    self.tableview.backgroundColor = [UIColor redColor];
    self.tableview.scrollEnabled = NO;
    [self nsNotificenter];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 6;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"交易明细";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"余额";
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"充值";
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"价格表";
    } else if (indexPath.row == 4) {
        cell.textLabel.text = @"常规问题";
    } else if (indexPath.row == 5) {
        cell.textLabel.text = @"关于我们";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        MoneyViewController *money = [[MoneyViewController alloc] init];
        [self presentViewController:money animated:YES completion:^{
            
        }];
    }else if (indexPath.row == 3) {
    
        PriceViewController *price = [[PriceViewController alloc] init];
        
        [self presentViewController:price animated:YES completion:^{
       
        }];
    }else if (indexPath.row == 4) {
    
        ComProblemViewController *comProblem = [[ComProblemViewController alloc] init];
    
        [self presentViewController:comProblem animated:YES completion:^{
            
        }];
        
    }else if (indexPath.row == 5) {
    
        AboutUsViewController *aboutUs = [[AboutUsViewController alloc] init];
        
        [self presentViewController:aboutUs animated:YES completion:^{
            
        }];
    
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HEIGHT / 5 + WIDTH / 20 + 50 +  WIDTH / 8 + 10 + 25;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    //用户
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableview.bounds.size.width, self.view.frame.size.height / 4)];
    view.backgroundColor = [UIColor colorWithWhite:0.790 alpha:1.000];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = CGRectMake(self.view.bounds.size.width * 0.7 / 2, view.centerY * 0.7 / 2, self.view.frame.size.width / 7, self.view.frame.size.width / 7);
    button.backgroundColor = [UIColor colorWithRed:1.000 green:0.895 blue:0.796 alpha:1.000];
    [view addSubview:button];
    
    [button addTarget:self action:@selector(pushUserPage:) forControlEvents:UIControlEventTouchUpInside];
    
    //buttonPhone
    
    self.buttonPhone = [UIButton buttonWithType:UIButtonTypeCustom];
    self.buttonPhone.frame = CGRectMake(self.view.bounds.size.width * 0.7 / 2 - 30, view.centerY * 0.7 / 2 + self.view.frame.size.width / 7 + 10, 120,WIDTH / 14);
    [view addSubview:self.buttonPhone];
    self.buttonPhone.backgroundColor = [UIColor orangeColor];
    [self.buttonPhone setTitle:@"请登录" forState:UIControlStateNormal];
    
    
    
    
    
    
    //
    UIImageView *imageOrder = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    [view addSubview:imageOrder];
    imageOrder.backgroundColor = [UIColor whiteColor];
    imageOrder.frame = CGRectMake(10, HEIGHT / 5 + 10, WIDTH / 4 * 3 / 10 ,  WIDTH / 4 * 3 / 10);
    
    //button
    UIButton *buttonMyOrder = [UIButton buttonWithType:UIButtonTypeCustom];
    [view addSubview:buttonMyOrder];
    buttonMyOrder.frame = CGRectMake(20 + WIDTH / 4 * 3 / 10, HEIGHT / 5 + 10, WIDTH / 4 * 3 / 2 - 20 - 20 - WIDTH / 4 * 3 / 10, view.frame.size.width / 10);
    buttonMyOrder.backgroundColor = [UIColor grayColor];
    [buttonMyOrder setTitle:@"我的订单" forState:UIControlStateNormal];
    buttonMyOrder.titleLabel.font = [UIFont systemFontOfSize:12];
    [buttonMyOrder addTarget:self action:@selector(pushMyOrder:) forControlEvents:UIControlEventTouchUpInside];
    buttonMyOrder.tag = 20;
    
    UIImageView *imageAllOrder = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    [view addSubview:imageAllOrder];
    imageAllOrder.frame = CGRectMake(WIDTH / 4 * 3 / 2 + 20 , HEIGHT / 5 + 10,  WIDTH / 4 * 3 / 10,  WIDTH / 4 * 3 / 10);
    imageAllOrder.backgroundColor = [UIColor whiteColor];
    
    //AllOrder
    UIButton *buttonAllOrder = [UIButton buttonWithType:UIButtonTypeCustom];
    [view addSubview:buttonAllOrder];
    buttonAllOrder.frame = CGRectMake(WIDTH / 4 * 3 / 2 + 30 + WIDTH / 4 * 3 / 10, HEIGHT / 5 + 10, WIDTH / 4 * 3 / 2 - 20 - 50, view.frame.size.width / 10);
    buttonAllOrder.backgroundColor = [UIColor grayColor];
    [buttonAllOrder setTitle:@"全部订单" forState:UIControlStateNormal];
    buttonAllOrder.titleLabel.font = [UIFont systemFontOfSize:12];
    [buttonAllOrder addTarget:self action:@selector(pushMyOrder:) forControlEvents:UIControlEventTouchUpInside];
    buttonAllOrder.tag = 20;

    
    
    NSInteger size = (WIDTH / 4 * 3) / 7;

  
    
    //待抢单
    
    UIButton *buttonWait = [UIButton buttonWithType:UIButtonTypeCustom];
    [view addSubview:buttonWait];
    buttonWait.frame = CGRectMake(size - 15, HEIGHT / 5 + view.frame.size.width / 20 + 50, size, size);
    buttonWait.backgroundColor = [UIColor whiteColor];
    buttonWait.layer.cornerRadius = size / 2;
    [buttonWait addTarget:self action:@selector(pushMyOrder:) forControlEvents:UIControlEventTouchUpInside];
    buttonWait.tag = 21;
    
    UIButton *buttonWaitN = [UIButton buttonWithType:UIButtonTypeCustom];
    [view addSubview:buttonWaitN];
    buttonWaitN.frame = CGRectMake(buttonWait.center.x - 35, HEIGHT / 5 + view.frame.size.width / 20 + 50 +  view.frame.size.width / 8 + 10, 70, 25);
    [buttonWaitN setTitle:@"待抢单" forState:UIControlStateNormal];
    [buttonWaitN addTarget:self action:@selector(pushMyOrder:) forControlEvents:UIControlEventTouchUpInside];
    buttonWaitN.tag = 21;
    
    //配送中
    
    UIButton *buttonDis = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonDis.frame = CGRectMake(size * 3 , HEIGHT / 5 + view.frame.size.width / 20 + 50,size, size);
    buttonDis.backgroundColor = [UIColor whiteColor];
    [view addSubview:buttonDis];
    buttonDis.layer.cornerRadius = size / 2;
    [buttonDis addTarget:self action:@selector(pushMyOrder:) forControlEvents:UIControlEventTouchUpInside];
    buttonDis.tag = 22;

    //
    UIButton *buttonDisN =[UIButton buttonWithType:UIButtonTypeCustom];
    buttonDisN.frame = CGRectMake(buttonDis.center.x - 35, HEIGHT / 5 + view.frame.size.width / 20 + 50 +  view.frame.size.width / 8 + 10, 70, 25);
    [view addSubview:buttonDisN];
    [buttonDisN setTitle:@"配送中" forState:UIControlStateNormal];
    [buttonDisN addTarget:self action:@selector(pushMyOrder:) forControlEvents:UIControlEventTouchUpInside];
    buttonDisN.tag = 22;

    
    //已完成
    
    UIButton *buttonComplete =[UIButton buttonWithType:UIButtonTypeCustom];
    buttonComplete.frame = CGRectMake(size * 5 + 15, HEIGHT / 5 + view.frame.size.width / 20 + 50, size, size);
    [view addSubview:buttonComplete];
    buttonComplete.backgroundColor = [UIColor whiteColor];
    buttonComplete.layer.cornerRadius = size / 2;
    [buttonComplete addTarget:self action:@selector(pushMyOrder:) forControlEvents:UIControlEventTouchUpInside];
    buttonComplete.tag = 23;

    UIButton *buttonCompleteN = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonCompleteN.frame = CGRectMake(buttonComplete.center.x - 35, HEIGHT / 5 + view.frame.size.width / 20 + 50 +  view.frame.size.width / 8 + 10, 70, 25);
    [view addSubview:buttonCompleteN];
    [buttonCompleteN setTitle:@"已完成" forState:UIControlStateNormal];
    [buttonCompleteN addTarget:self action:@selector(pushMyOrder:) forControlEvents:UIControlEventTouchUpInside];

    buttonCompleteN.tag = 23;
    
    return view;
}


- (void)pushMyOrder:(UIButton *)button {

    OrderViewController *order = [[OrderViewController alloc] init];
    NSIndexPath *index = [NSIndexPath indexPathForItem:button.tag - 20 inSection:0];
    
    order.index = index;
    [self presentViewController:order animated:YES completion:^{
        
    }];
    
}


- (void)pushUserPage:(UIButton *)button {

    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UserPageViewController *userPage = [[UserPageViewController alloc] init];
    
    if (self.dicContext == nil) {
        [tempAppDelegate.mainNavigationController pushViewController:userPage animated:YES];
    }else {
    
    
        
    }
    [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
}

- (void)nsNotificenter {
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"SignSure" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
        NSDictionary *dic = [note.userInfo objectForKey:@"contect"];
        NSLog(@"--%@",dic);

//        [self.buttonPhone setTitle:[dicContect objectForKey:@"Accounts"] forState:UIControlStateNormal];
        
        
        AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [tempAppDelegate.LeftSlideVC openLeftView];
        
        
    }];
    
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if ([self iPhonesModel] == 0) {
        return 38;
    }else {
    
    return 44;
    }
}

- (iPhoneModel)iPhonesModel {


    CGRect rect = [[UIScreen mainScreen] bounds];
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    //get current interface Orientation
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    //unknown
    if (UIInterfaceOrientationUnknown == orientation) {
        return UnKnown;
    }
    
    if (UIInterfaceOrientationPortrait == orientation) {
        if (width ==  320.0f) {
            if (height == 480.0f) {
                return iPhone4;
            } else {
                return iPhone5;
            }
        } else if (width == 375.0f) {
            return iPhone6;
        } else if (width == 414.0f) {
            return iPhone6Plus;
        }
    }else if (UIInterfaceOrientationLandscapeLeft == orientation || UIInterfaceOrientationLandscapeRight == orientation) {
        //landscape
    
        if (height == 320.0) {
            if (width == 480.0f) {
                return iPhone4;
            } else {
                return iPhone5;
            }
        } else if (height == 375.0f) {
            return iPhone6;
        } else if (height == 414.0f) {
            return iPhone6Plus;
        }
    }
    return UnKnown;
}



@end
