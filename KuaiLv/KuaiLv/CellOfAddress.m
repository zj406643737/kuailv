//
//  CellOfAddress.m
//  KuaiLv
//
//  Created by 刘啸天 on 16/8/9.
//  Copyright © 2016年 GH. All rights reserved.
//

#import "CellOfAddress.h"

@implementation CellOfAddress

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
    self.didian = [[UIImageView alloc]init];
    [self.contentView addSubview:self.didian];
    self.didian.backgroundColor = [UIColor redColor];
    
    self.addressName = [[UILabel alloc]init];
    [self.contentView addSubview:self.addressName];
    self.addressName.backgroundColor = [UIColor orangeColor];
    
    self.addressName.text = @"同心幼儿园";
    
    self.address = [[UILabel alloc]init];
    [self.contentView addSubview:self.address];
    self.address.text = @"黑龙江省哈尔滨市南岗区";
    self.address.backgroundColor = [UIColor grayColor];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width = self.contentView.frame.size.width;
    self.didian.frame = CGRectMake(5, 20, 20, 20);
    self.addressName.frame = CGRectMake(30, 5, width - 45, 20);
    self.address.frame = CGRectMake(30, 35, width - 45, 20);
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
