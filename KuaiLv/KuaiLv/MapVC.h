//
//  MapVC.h
//  KuaiLv
//
//  Created by 刘啸天 on 16/8/9.
//  Copyright © 2016年 GH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapVC : UIViewController
@property (nonatomic,strong)UIView *backview;
@property (nonatomic,strong)UIButton *backbutton;
@property (nonatomic,strong)UIButton *pointaddress;
@property (nonatomic,strong)UILabel *wordLabel;
@property (nonatomic,strong) UIImageView *imageback;
@property (nonatomic,strong) UITableView *tableview;

@property (nonatomic,strong) NSMutableArray *arraycity;
@property (nonatomic,assign)NSInteger pointnumber;

@end
