//
//  CellOfMapAddress.m
//  KuaiLv
//
//  Created by 刘啸天 on 16/8/11.
//  Copyright © 2016年 GH. All rights reserved.
//

#import "CellOfMapAddress.h"

@implementation CellOfMapAddress

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self  creatview];
        
        
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
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width = self.contentView.frame.size.width;
    self.viewback.frame = CGRectMake(0, 0, width , 65);
    self.labeladdress.frame = CGRectMake(0, 40, width, 25);
    self.labelname.frame = CGRectMake(0, 5, width , 35);
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
