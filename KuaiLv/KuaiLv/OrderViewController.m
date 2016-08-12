//
//  OrderViewController.m
//  KuaiLv
//
//  Created by GH on 16/8/4.
//  Copyright © 2016年 GH. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderCollectionViewCell.h"

#define WIDTH self.view.frame.size.width
#define HEIGHT  self.view.frame.size.height

@interface OrderViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic ,strong)UIScrollView *scrollview;
@property (nonatomic ,strong)UIView *viewOfMove;




@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self createView];
    [self createCollection];
    [self createScrollTitle];
    [self createKVCvalue];
    
    [self.collectionview scrollToItemAtIndexPath:_index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    
}

- (void)createCollection {

    //flowlayout
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
    
    flowlayout.itemSize = CGSizeMake(WIDTH, HEIGHT - 34);
    flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowlayout.minimumInteritemSpacing = 0;
    flowlayout.minimumLineSpacing = 0;
    
    
    //collection
    self.collectionview = [[UICollectionView alloc] initWithFrame:CGRectMake(0,92, WIDTH, HEIGHT - 34) collectionViewLayout:flowlayout];
    self.collectionview.backgroundColor = [UIColor whiteColor];
    
    self.collectionview.pagingEnabled = YES;
    self.collectionview.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:self.collectionview];
    
    //代理
    self.collectionview.delegate = self;
    self.collectionview.dataSource = self;
    
    [self.collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"pool"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 4;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    OrderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"pool" forIndexPath:indexPath];
    
    
    cell.backgroundColor =  [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    return cell;
}

- (void)createScrollTitle {
 
    NSArray *arrTitle = @[@"全部",@"待抢单",@"配送中",@"已完成"].mutableCopy;
    
    self.scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, 30)];
    
    self.scrollview.backgroundColor = [UIColor grayColor];
    self.scrollview.pagingEnabled = YES;
    //滑动条
    self.scrollview.showsHorizontalScrollIndicator = NO;

    self.scrollview.contentSize = CGSizeMake(WIDTH / 4 * arrTitle.count, 0);
    self.scrollview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.scrollview];
    
    for (int i = 0; i < arrTitle.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:arrTitle[i] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(handleOffset:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i+1;
        button.frame = CGRectMake(WIDTH / 4 * i, 0, WIDTH / 4 , 25);
        [self.scrollview addSubview:button];
        button.backgroundColor = [UIColor grayColor];
    }
    
    [self createviewOfMove];
    
}

-(void)handleOffset:(UIButton *)button {
    
    NSIndexPath * path = [NSIndexPath indexPathForItem:button.tag - 1 inSection:0];
    [self.collectionview scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    
}

- (void)createviewOfMove {
    self.viewOfMove = [[UIView alloc] init];
    self.viewOfMove.backgroundColor = [UIColor redColor];
    self.viewOfMove.frame = CGRectMake(WIDTH / 8 / 2, 90, WIDTH / 4 / 2, 2);
    [self.view addSubview:self.viewOfMove];
    
    
}

- (void)createKVCvalue {
    //在conection上添加观察着
    [self.collectionview addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:@"context"];
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    CGFloat x = [[change objectForKey:@"new"] CGPointValue].x;
    
    
    CGFloat redX = x / 4;
    //修改 redline 位置
    self.viewOfMove.transform = CGAffineTransformMakeTranslation(redX, 0);
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
    label.text = @"我的订单";
    label.textAlignment = 1;
    label.font = [UIFont systemFontOfSize:17];
    [view addSubview:label];

}

- (void)disMissVC {
    [self dismissViewControllerAnimated:YES completion:^{
    }];

}

- (void)dealloc {
    [self.collectionview removeObserver:self forKeyPath:@"contentOffset"];
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
