//
//  CellOfMapAddress2.m
//  KuaiLv
//
//  Created by 刘啸天 on 16/8/11.
//  Copyright © 2016年 GH. All rights reserved.
//

#import "CellOfMapAddress2.h"
#import <QuartzCore/QuartzCore.h>
@implementation CellOfMapAddress2

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self  creatview];
        self.contentView.layer.borderWidth = 2;
        self.contentView.layer.borderColor = [[UIColor colorWithRed:0.35 green:0.68 blue:0.88 alpha:1] CGColor];
    
    }
    return self;
    
}
-(void)creatview{
    self.viewback = [[UIView alloc]init];
    [self.contentView addSubview:self.viewback];
    self.viewback.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1];
    
    self.labelname = [[UILabel alloc]init];
    [self.viewback addSubview:self.labelname];
    self.labelname.backgroundColor = [UIColor whiteColor];
    self.labelname.font = [UIFont systemFontOfSize:19];
    
    
    self.labeladdress = [[UILabel alloc]init];
    [self.viewback addSubview:self.labeladdress];
    self.labeladdress.backgroundColor = [UIColor whiteColor];
    
    self.labeladdress.font = [UIFont  systemFontOfSize:17];
    self.labeladdress.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    
    self.imageduigou = [[UIImageView alloc]init];
    [self.contentView addSubview:self.imageduigou];
    self.imageduigou.image = [UIImage imageNamed:@"对勾"];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width = self.contentView.frame.size.width;
    CGFloat height = self.contentView.frame.size.height;
    self.viewback.frame = CGRectMake(0, 0, width , 65);
    self.labeladdress.frame = CGRectMake(0, 40, width, 25);
    self.labelname.frame = CGRectMake(0, 5, width , 35);
    self.imageduigou.frame = CGRectMake(0, 0, 30, 30);
    self.imageduigou.center = CGPointMake(width - 20, height * 0.5);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
