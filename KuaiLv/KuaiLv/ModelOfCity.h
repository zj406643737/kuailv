//
//  ModelOfCity.h
//  KuaiLv
//
//  Created by 刘啸天 on 16/8/11.
//  Copyright © 2016年 GH. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AMapGeoPoint;
@interface ModelOfCity : NSObject

@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *address;
@property (nonatomic,strong)NSString *city;
@property (nonatomic,strong)AMapGeoPoint *loaction;
@property (nonatomic,assign)NSInteger  distance;


@end
