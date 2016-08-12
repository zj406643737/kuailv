//
//  VIewOfMap.m
//  KuaiLv
//
//  Created by 刘啸天 on 16/8/9.
//  Copyright © 2016年 GH. All rights reserved.
//

#import "VIewOfMap.h"

@implementation VIewOfMap

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype) initWithFrame:(CGRect)frame {
    
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.image = [[UIImageView alloc]initWithFrame:CGRectMake(5, 17, 30, 30)];
        self.image.backgroundColor = [UIColor redColor];
        [self addSubview:self.image];
        
        self.map = [[UILabel alloc]initWithFrame:CGRectMake(40, 22, frame.size.width - 35, 20)];
        [self addSubview:self.map];
        self.map.text = @"地图选址";
        self.map.textColor = [UIColor blueColor];
        
    }
    
    
    return self;
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"进入地图界面");
    self.block();
    
}


@end
