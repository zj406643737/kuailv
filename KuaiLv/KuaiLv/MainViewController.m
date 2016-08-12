//
//  MainViewController.m
//  KuaiLv
//
//  Created by GH on 16/8/1.
//  Copyright © 2016年 GH. All rights reserved.
//

#import "MainViewController.h"
#import "RegisterTableViewCell.h"
#import "ButtonWithPickerView.h"
#import "AppDelegate.h"
#import "MakeOrderViewController.h"
#import "TheSenderViewController.h"
#import "TheReceiveViewController.h"
#import <MBProgressHUD.h>

#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UIImageView *imageOfActive;
@property (nonatomic ,strong) UITableView *tableview;
@property (nonatomic ,strong) RegisterTableViewCell *cellOfRegister;
@property (nonatomic ,strong) UIView *viewOfHeight;
@property (nonatomic ,strong) UILabel *labelOfHeight;
@property (nonatomic ,assign) NSInteger number;
@property (nonatomic ,strong) UIButton *buttonOfOrder;


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.829 alpha:1.000];
    
    [self createTableview];
    [self createActiveImage];
    [self createHeightView];
    [self createOrderButton];
    [self createNavigation];
    
    
}


- (void)createTableview {
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + HEIGHT / 4 + 10, WIDTH, HEIGHT / 3) style:UITableViewStylePlain];
    [self.view addSubview:self.tableview];
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    [self.tableview registerClass:[RegisterTableViewCell class] forCellReuseIdentifier:@"pool"];
    self.tableview.scrollEnabled = NO;
    self.tableview.backgroundColor = [UIColor blueColor];
    //设置cell 和tableview 原点一致
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    RegisterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pool"];
    
    cell.backgroundColor = [UIColor grayColor];

    
    if (indexPath.row == 0) {
        cell.labelOfMessage.text = @"请输入寄件人信息";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    } else if (indexPath.row == 1) {
        cell.labelOfMessage.text = @"请输入收件人信息";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    } else if (indexPath.row == 2) {
            
        ButtonWithPickerView *button = [ButtonWithPickerView buttonWithType:UIButtonTypeCustom];
        [cell addSubview:button];
        button.frame = CGRectMake(HEIGHT /9 , 10, cell.frame.size.width , HEIGHT / 9 - 20);
        [button addTarget:self action:@selector(packView:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"立即取件" forState:UIControlStateNormal];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
    [[NSNotificationCenter defaultCenter] addObserverForName:@"Sender" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
        NSString *string = [note.userInfo objectForKey:@"key"];
        cell.labelOfMessage.text = string;
        cell.labelOfMessage.textColor = [UIColor blackColor];
        cell.labelOfMessage.font = [UIFont systemFontOfSize:15];
    }];
    }
    if (indexPath.row == 1) {
        [[NSNotificationCenter defaultCenter] addObserverForName:@"Received" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
            NSString *string = [note.userInfo objectForKey:@"key"];
            cell.labelOfMessage.text = string;
            cell.labelOfMessage.textColor = [UIColor blackColor];
            cell.labelOfMessage.font = [UIFont systemFontOfSize:15];
        }];
    }
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return HEIGHT / 3 / 3;
}


- (void)packView:(UIButton *)button {

    [button becomeFirstResponder];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        TheSenderViewController *theSender = [[TheSenderViewController alloc] init];
        [self presentViewController:theSender animated:YES completion:^{
            
        }];
    }else if (indexPath.row == 1) {
    
        TheReceiveViewController *theReceive = [[TheReceiveViewController alloc] init];
        [self presentViewController:theReceive animated:YES completion:^{
            
        }];
    
    
    }

    
    
}



- (void)createActiveImage {
    
    self.imageOfActive = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    [self.view addSubview:self.imageOfActive];
    self.imageOfActive.backgroundColor = [UIColor redColor];
    self.imageOfActive.frame = CGRectMake(0, 64, WIDTH, HEIGHT / 4);

}


- (void)createHeightView {

    self.viewOfHeight = [[UIView alloc] initWithFrame:CGRectMake(WIDTH /8, 64 + 10 + HEIGHT / 4 + HEIGHT / 3 + HEIGHT / 15, WIDTH / 8 * 6, HEIGHT / 15)];
    [self.view addSubview:self.viewOfHeight];
    self.viewOfHeight.backgroundColor = [UIColor grayColor];
    
    self.viewOfHeight.layer.cornerRadius = 15;
    
    //add
    UIButton *buttonAdd = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonAdd.frame = CGRectMake(self.viewOfHeight.frame.size.width /5 * 4 - 5, 5, self.viewOfHeight.frame.size.width / 5, self.viewOfHeight.frame.size.height - 10);
    [self.viewOfHeight addSubview:buttonAdd];
    buttonAdd.backgroundColor = [UIColor blackColor];
    [buttonAdd addTarget:self action:@selector(buttonAddSeleter:) forControlEvents:UIControlEventTouchUpInside];
    
    //sub
    
    UIButton *buttonSub = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonSub.frame = CGRectMake(5, 5, self.viewOfHeight.frame.size.width / 5, self.viewOfHeight.frame.size.height - 10);
    [self.viewOfHeight addSubview:buttonSub];
    buttonSub.backgroundColor = [UIColor blackColor];
    [buttonSub addTarget:self action:@selector(buttonSubSeleter:) forControlEvents:UIControlEventTouchUpInside];
    

    //label
    self.labelOfHeight = [[UILabel alloc] initWithFrame:CGRectMake(5 + buttonAdd.frame.size.width, 5, self.viewOfHeight.frame.size.width / 5 * 3, self.viewOfHeight.frame.size.height - 10)];
    [self.viewOfHeight addSubview:self.labelOfHeight];
    self.labelOfHeight.text = @"5公斤以下";
    self.labelOfHeight.textAlignment = 1;
    

    self.number = 5;
    
}

- (void)buttonAddSeleter: (UIButton *)button {
    if (self.number < 5) {
        self.number = 5;
    }
    
    self.number ++;
    NSString *height = [NSString stringWithFormat:@"%ld公斤",(long)self.number];
    
    self.labelOfHeight.text = height;
}

- (void)buttonSubSeleter: (UIButton *)button {
    self.number --;
    NSString *heght = [ NSString stringWithFormat:@"%ld公斤",(long)self.number];
    self.labelOfHeight.text = heght;
    if (self.number < 6) {
        self.labelOfHeight.text = @"5公斤以下";
    }

}


- (void)createOrderButton {

    self.buttonOfOrder = [UIButton buttonWithType:UIButtonTypeSystem];
    self.buttonOfOrder.frame = CGRectMake(10, HEIGHT / 10 * 9, WIDTH - 20, HEIGHT / 10 - 5);
    [self.view addSubview:self.buttonOfOrder];
    
    self.buttonOfOrder.backgroundColor = [UIColor colorWithWhite:0.903 alpha:1.000];
    
    self.buttonOfOrder.layer.cornerRadius = 15;
    [self.buttonOfOrder setTitle:@"下单" forState:UIControlStateNormal];
    self.buttonOfOrder.titleLabel.font = [UIFont systemFontOfSize:20];
    
    
    [self.buttonOfOrder addTarget:self action:@selector(makeOrder) forControlEvents:UIControlEventTouchUpInside];
}

- (void)makeOrder {

    MakeOrderViewController * makeOrder= [[MakeOrderViewController alloc] init];
    
    [self.navigationController pushViewController:makeOrder animated:YES];
}




- (void)createNavigation {

    self.navigationItem.title = @"快驴";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(ditoAction:)];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"2"] style:UIBarButtonItemStylePlain target:self action:@selector(ditoAction:)];
    
    UIBarButtonItem * item2 = [[UIBarButtonItem alloc] initWithTitle:@"哈尔滨" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction:)];
    self.navigationItem.rightBarButtonItems =@[item2,item1];
    
}

- (void)ditoAction:(UIBarButtonItem *)item {

    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (tempAppDelegate.LeftSlideVC.closed)
    {
        [tempAppDelegate.LeftSlideVC openLeftView];
    }
    else
    {
        [tempAppDelegate.LeftSlideVC closeLeftView];
    }

    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:YES];
}

- (void)saveAction:(UIBarButtonItem *)item {

}



- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self];


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
