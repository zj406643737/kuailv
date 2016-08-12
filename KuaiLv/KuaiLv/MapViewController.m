//
//  MapViewController.m
//  KuaiLv
//
//  Created by 刘啸天 on 16/8/9.
//  Copyright © 2016年 GH. All rights reserved.
//

#import "MapViewController.h"
#import "CellOfAddress.h"
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
#import <MAMapKit/MAMapKit.h>
#import "ViewOfAddress.h"
#import "VIewOfMap.h"
#import <CoreLocation/CoreLocation.h>
#import "MapVC.h"

@interface MapViewController ()<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>

@property (nonatomic,retain) UITableView *tableview;
@property (nonatomic,retain) CLLocationManager *manager;


@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any addit
    [self doSomething];

    self.view.backgroundColor = [UIColor whiteColor];
    
    UISearchBar *bar = [[UISearchBar alloc]initWithFrame:CGRectMake(45, 20, WIDTH -50, 40)];
    bar.backgroundColor = [UIColor blueColor];
    bar.placeholder = @"请输入小区名，大厦名，街道门牌号";
    [self.view addSubview:bar];
    
    UIButton *buttonreturn = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonreturn.frame = CGRectMake(5, 20, 40, 40);
    buttonreturn.backgroundColor = [UIColor redColor];
    [self.view addSubview:buttonreturn];
    
    [buttonreturn addTarget:self action:@selector(dismissViewController) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *buttonview = [[UIView alloc]initWithFrame:CGRectMake(0,64,WIDTH, 64)];
    buttonview.backgroundColor = [UIColor grayColor];
    [self.view addSubview:buttonview];
    
    //键入两个特殊的界面;
    //使用当前的地址的界面
    ViewOfAddress *viewaddress = [[ViewOfAddress alloc]initWithFrame:CGRectMake(0, 0,WIDTH -130, 62.5)];
    
    [buttonview addSubview:viewaddress];
    
    
    viewaddress.block = ^(){
        
        NSLog(@"已经成功定位,并且返回定位的值");
    };
    //开启点图的页面
    
    VIewOfMap *viewMap = [[VIewOfMap alloc]initWithFrame:CGRectMake(WIDTH - 130, 0, 130, 62.5)];
    [buttonview addSubview:viewMap];
    viewMap.block = ^(){
        NSLog(@"已经成功进入地图界面");
        
        MapVC *vc = [[MapVC alloc]init];
        [self presentViewController:vc animated:YES completion:^{
            
        }];

    };

    
//    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 128, WIDTH, HEIGHT - 128) style:UITableViewStylePlain];
     self.tableview.backgroundColor = [UIColor orangeColor];
    self.tableview.delegate = self;
     self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
//    self.tableview.separatorStyle = UITableViewCellAccessoryNone;
    [self.tableview registerClass:[CellOfAddress class] forCellReuseIdentifier:@"poolcellForaddress"];
    
    
    
}

//实现协议方法

-(void)doSomething{
    self.manager = [[CLLocationManager alloc] init];
    
    self.manager.delegate = self;
    
    // 请求授权，记得修改的infoplist，NSLocationAlwaysUsageDescription（描述）
    [self.manager requestAlwaysAuthorization];
    self.manager.desiredAccuracy = kCLLocationAccuracyBest;
    self.manager.distanceFilter = kCLDistanceFilterNone;


    if ([CLLocationManager locationServicesEnabled]) {
        
        // 启动位置更新
        
        // 开启位置更新需要与服务器进行轮询所以会比较耗电，在不需要时用stopUpdatingLocation方法关闭;
        
        [self.manager startUpdatingLocation];
        
        NSLog(@"开启成功");
        
    } else {
        
        NSLog(@"请开启定位功能！");
        
    }
    
  }


#pragma mark - 定位代理
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations

{
    
    CLLocation *newLocation = locations[0];
    
    // 位置反编码
    
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error){
        
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        
        NSLog(@"%@", placemark.name);// 详细位置
        
        NSLog(@"%@",
             placemark.country);// 国家
        
        NSLog(@"%@",
             placemark.locality);// 市
        
        NSLog(@"%@",
             placemark.subLocality);// 区
        
        
        NSLog(@"%@",
             placemark.thoroughfare);// 街道
        
        
        NSLog(@"%@",
             placemark.subThoroughfare);// 子街道
        
    }];
    
    [manager stopUpdatingLocation];
    
}


// 定位失误时触发

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error

{
  
    NSLog(@"error:%@",error);
    
}



- (void)dismissViewController{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    NSLog(@"退出VC");
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CellOfAddress *cell = [[CellOfAddress alloc]init];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
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
