//
//  VIewOfMap.h
//  KuaiLv
//
//  Created by 刘啸天 on 16/8/9.
//  Copyright © 2016年 GH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VIewOfMap : UIView

@property (nonatomic,retain) UIImageView *image;

@property (nonatomic,retain) UILabel *map;

@property (nonatomic,copy)void(^block)();


@end
