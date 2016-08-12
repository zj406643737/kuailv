//
//  ViewOfAddress.h
//  KuaiLv
//
//  Created by 刘啸天 on 16/8/9.
//  Copyright © 2016年 GH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewOfAddress : UIView

@property (nonatomic,retain) UILabel *dizhi;

@property (nonatomic,retain) UIImageView *image;

@property (nonatomic,retain) UILabel *jingtai;

@property (nonatomic,retain) UIView *lineview;

@property (nonatomic,copy)void(^block)();

@end
