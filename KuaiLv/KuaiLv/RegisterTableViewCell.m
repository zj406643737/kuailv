//
//  RegisterTableViewCell.m
//  KuaiLv
//
//  Created by GH on 16/8/1.
//  Copyright © 2016年 GH. All rights reserved.
//

#import "RegisterTableViewCell.h"

@interface RegisterTableViewCell ()

@property (nonatomic, strong)UIImageView *imageOfregister;
@property (nonatomic ,strong)UIView *ViewOfBack;

@end

@implementation RegisterTableViewCell




- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {


    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self createMessageLabel];
        [self createRegisterImage];
    }

    return self;
}

- (void) createMessageLabel {
    
    self.ViewOfBack = [[UIView alloc] init];
    [self.contentView addSubview:self.ViewOfBack];
    self.ViewOfBack.backgroundColor = [UIColor whiteColor];

    self.labelOfMessage = [[UILabel alloc] init];
    [self.ViewOfBack addSubview:self.labelOfMessage];
    self.labelOfMessage.backgroundColor = [UIColor whiteColor];
    self.labelOfMessage.textColor = [UIColor grayColor];
    self.labelOfMessage.numberOfLines = 0;
    self.labelOfMessage.lineBreakMode = NSLineBreakByTruncatingTail;
//
}

- (void)createRegisterImage {
    self.imageOfregister = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    self.imageOfregister.backgroundColor = [UIColor orangeColor];
    [self.ViewOfBack addSubview:self.imageOfregister];
//
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.ViewOfBack.frame = CGRectMake(0, 2, self.frame.size.width, self.frame.size.height - 2);
    
    self.imageOfregister.frame = CGRectMake(10, 10, self.frame.size.height - 20, self.frame.size.height - 20);
    self.imageOfregister.layer.masksToBounds = YES;
    self.imageOfregister.layer.cornerRadius = (self.frame.size.height - 20) / 2;

    //label
    self.labelOfMessage.frame = CGRectMake(10 + self.frame.size.height - 20 +10 , 0, self.frame.size.width - (self.frame.size.height - 10) * 2, self.frame.size.height - 2);
    
    
}

- (void)awakeFromNib {
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
