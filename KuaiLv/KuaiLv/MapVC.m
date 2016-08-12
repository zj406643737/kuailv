//
//  MapVC.m
//  KuaiLv
//
//  Created by 刘啸天 on 16/8/9.
//  Copyright © 2016年 GH. All rights reserved.
//

#import "MapVC.h"
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "CellOfMapAddress.h"
#import "CellOfMapAddress2.h"
#import "ModelOfCity.h"


@interface MapVC ()<MAMapViewDelegate,UITableViewDataSource,UITableViewDelegate,AMapSearchDelegate>


{
    MAMapView *_mapview;
    AMapSearchAPI *_search;
}

@end

@implementation MapVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1];
    self.pointaddress = 0;
    [self creatMapview];
    [self creatview];
}
-(void)creatview{
   
    self.backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    [self.view addSubview:self.backview];
    self.backview.backgroundColor = [UIColor whiteColor];
    
    self.backbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backbutton.backgroundColor = [UIColor redColor];
    self.backbutton.frame = CGRectMake(5, 29, 30, 30);
    [self.backbutton addTarget:self action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
    [self.backview addSubview:self.backbutton];

    self.wordLabel = [[UILabel alloc]init];
    self.wordLabel.text = @"地图选址";
    self.wordLabel.frame = CGRectMake(40, 29, WIDTH - 120, 30);
    [self.backview addSubview:self.wordLabel];
    self.wordLabel.textAlignment = 1;
    self.wordLabel.backgroundColor =[UIColor redColor];
    self.wordLabel.center = CGPointMake(WIDTH / 2, 44);
    
    self.pointaddress = [UIButton buttonWithType:UIButtonTypeCustom];
    self.pointaddress.backgroundColor = [UIColor redColor];
    [self.backview addSubview:self.pointaddress];
    [self.pointaddress addTarget:self action:@selector(pointTheAddress) forControlEvents:UIControlEventTouchUpInside];
    self.pointaddress.frame = CGRectMake(WIDTH - 50, 29, 45, 30);
    [self.pointaddress setTitle:@"确定" forState:UIControlStateNormal];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(10, 64 + 0.7 * WIDTH, WIDTH - 20, HEIGHT - 64 - 0.7 *WIDTH) style:UITableViewStylePlain];
    self.tableview.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1];
    [self.view addSubview:self.tableview];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    [self.tableview registerClass:[CellOfMapAddress class] forCellReuseIdentifier:@"pool"];
    [self.tableview registerClass:[CellOfMapAddress2 class] forCellReuseIdentifier:@"pool2"];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arraycity.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.pointnumber) {
        CellOfMapAddress2 *cell = [[CellOfMapAddress2 alloc]init];
        ModelOfCity *model = [self.arraycity objectAtIndex:indexPath.row];
        cell.labeladdress.text = [NSString stringWithFormat:@"  %@",model.address];
        cell.labelname.text = [NSString stringWithFormat:@"  %@",model.name];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
    
    CellOfMapAddress *cell = [[CellOfMapAddress alloc]init];
    ModelOfCity *model = [self.arraycity objectAtIndex:indexPath.row];
    cell.labeladdress.text = [NSString stringWithFormat:@"  %@",model.address];
    cell.labelname.text = [NSString stringWithFormat:@"  %@",model.name];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%ld",indexPath.row);
    self.pointnumber = indexPath.row;
    [self.tableview reloadData];
    
    ModelOfCity *model = [self.arraycity objectAtIndex:indexPath.row];
    
    _mapview.centerCoordinate = CLLocationCoordinate2DMake(model.loaction.latitude,model.loaction.longitude);
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 65;
}
#pragma mark  地图的界面的代码;
-(void)creatMapview{
    NSLog(@"创造地图页面");
    [AMapServices sharedServices].apiKey = @"898e49d99587a5b65d4659503d59830d";
    
    _mapview= [[MAMapView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, WIDTH * 0.7)];
     _mapview.delegate = self;
    
    [self.view addSubview: _mapview];
    
    self.imageback = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    self.imageback.image = [UIImage imageNamed:@"地点"];
    [_mapview addSubview:self.imageback];
    self.imageback.center = CGPointMake(WIDTH *  0.5, WIDTH * 0.35 - 18) ;
#pragma mark 开启自己的定位
    
//     _mapview.showsUserLocation = YES;
//     _mapview.userTrackingMode = MAUserTrackingModeFollowWithHeading;
//    
//    [ _mapview setZoomLevel:16.2 animated:YES];
//    _mapview.centerCoordinate = _mapview.userLocation.location.coordinate;
   _mapview.centerCoordinate = CLLocationCoordinate2DMake(45.707675,126.636819);

    MACoordinateSpan span = MACoordinateSpanMake(0.004913, 0.033695);
    MACoordinateRegion region = MACoordinateRegionMake(_mapview.centerCoordinate, span);
    _mapview.region = region;
    
#pragma mark  POI周边搜索
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;
    
    //构造AMapPOIAroundSearchRequest对象，设置周边请求参数
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    request.location = [AMapGeoPoint locationWithLatitude:45.707675 longitude:126.636819];
    // types属性表示限定搜索POI的类别，默认为：餐饮服务|商务住宅|生活服务
    
    request.types = @"餐饮服务|生活服务|政府机构及社会团体|公司企业|商务住宅";
    request.sortrule = 0;
    request.requireExtension = YES;
    
    //发起周边搜索
    [_search AMapPOIAroundSearch: request];


}
- (void)mapView:(MAMapView *)mapView mapWillMoveByUser:(BOOL)wasUserAction{
    if (wasUserAction == YES) {
        NSLog(@"使用户移动的");
        CGPoint point = CGPointMake(WIDTH * 0.5, WIDTH *0.35 + 64);
        CLLocationCoordinate2D touchMapCoordinate = [_mapview convertPoint:point toCoordinateFromView:_mapview];
        
        AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
        request.location = [AMapGeoPoint locationWithLatitude:touchMapCoordinate.latitude longitude:touchMapCoordinate.longitude];
        // types属性表示限定搜索POI的类别，默认为：餐饮服务|商务住宅|生活服务
        
        request.types = @"餐饮服务|生活服务|政府机构及社会团体|科教文化服务|公司企业|地名地址信息|公共设施|商务住宅";
        request.sortrule = 0;
        request.requireExtension = YES;
        
        //发起周边搜索
        [_search AMapPOIAroundSearch: request];
        self.pointnumber = 0;
        [self.tableview reloadData];

    }else{
        NSLog(@"自动的移动的");
        
    }
}
#pragma mark 监视地图

- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if(response.pois.count == 0)
    {
        return;
    }
     self.arraycity = [NSMutableArray array];
//通过 AMapPOISearchResponse 对象处理搜索结果
//    NSString *strSuggestion = [NSString stringWithFormat:@"Suggestion: %@", response.suggestion.cities];
//    NSArray *arr = [NSArray arrayWithArray:response.suggestion.keywords];
    
    NSString *strPoi = @"";
    
    for (AMapPOI *p in response.pois) {
        strPoi = [NSString stringWithFormat:@"%@\nPOI: %@", strPoi, p.address];
//        NSLog(@"%@",strPoi);
        ModelOfCity *model = [[ModelOfCity alloc]init];
        model.name = p.name;
       model.loaction = p.location;
        model.address = p.address;
        model.distance = p.distance;
        model.city = p.city;

        [self.arraycity addObject:model];
    }
    [self.tableview reloadData];
}
//时刻消耗内存  所以先注释掉
//-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
//updatingLocation:(BOOL)updatingLocation
//{
//    NSLog(@"asdasd");
//    if(updatingLocation)
//    {
//        //取出当前位置的坐标
//        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
//    }
//}

-(void)dismissVC{
    [self dismissViewControllerAnimated:YES completion:^{
           NSLog(@"回退VC");
    }];
}
-(void)pointTheAddress{
    
    NSLog(@"确定地址,然后回传地址");
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
