//
//  ViewOfAddress.m
//  KuaiLv
//
//  Created by 刘啸天 on 16/8/9.
//  Copyright © 2016年 GH. All rights reserved.
//

#import "ViewOfAddress.h"

@implementation ViewOfAddress

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.jingtai = [[UILabel alloc]initWithFrame:CGRectMake(40, 10, frame.size.width - 40,20)];
        [self addSubview:self.jingtai];
        self.jingtai.text = @"使用当前位置:";
        self.jingtai.textColor = [UIColor blueColor];
        
        self.image = [[UIImageView alloc]initWithFrame:CGRectMake(5, 17, 30, 30)];
        self.image.image = [UIImage imageNamed:@"地点"];
        [self addSubview:self.image];
        
        
        self.dizhi = [[UILabel alloc]initWithFrame:CGRectMake(40, 35, frame.size.width - 40, 15)];
        [self addSubview:self.dizhi];
        self.dizhi.text = @"黑龙江省哈尔滨南岗区启智路";
        self.dizhi.textColor = [UIColor  blackColor];
        
        self.lineview = [[UIView alloc]initWithFrame:CGRectMake(frame.size.width - 1, 10, 1, 44)];
        [self addSubview:self.lineview];
        self.lineview.backgroundColor = [UIColor grayColor];
        
    }
    return self;
}



- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"使用当前的地址");
    
    self.block();
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
