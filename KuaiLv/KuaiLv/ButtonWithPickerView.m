//
//  ButtonWithPickerView.m
//  PickerViewDemo
//
//  Created by FrankLiu on 15/12/24.
//  Copyright © 2015年 FrankLiu. All rights reserved.
//

#import "ButtonWithPickerView.h"

#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface ButtonWithPickerView () <UIPickerViewDataSource,UIPickerViewDelegate>

// 将UIResponder的这两个readonly属性变为readwrite
@property (nonatomic,strong,readwrite) __kindof UIView * inputView;
@property (nonatomic,strong,readwrite) __kindof UIView * inputAccessoryView;
@property (nonatomic, strong) NSMutableArray  *m_yearArray;
@property (nonatomic, strong) NSMutableArray  *m_monthArray;
@property (nonatomic, strong) NSMutableArray  *m_dayArray;
@property (nonatomic, strong) NSMutableArray  *m_mothcurArray;
@property (nonatomic, strong) NSString * m_yearStr;
@property (nonatomic, strong) NSString * m_monthStr;
@property (nonatomic, strong) NSString * m_dayStr;
@property (nonatomic, strong) UIPickerView *pickView;
@property (nonatomic, assign) NSInteger row;

@end

@implementation ButtonWithPickerView

// 这个方法必须实现
- (BOOL) canBecomeFirstResponder {
    
    return YES;
}

// inputView背景色设为透明是无效的
- (UIPickerView *)inputView {

    if (_inputView == nil) {
        
        self.m_yearArray  = [NSMutableArray arrayWithArray:@[@"今天",@"明天"]];
        self.m_monthArray = [NSMutableArray arrayWithArray:@[@"00点",@"01点",@"02点",@"03点",@"04点",@"05点",@"06点",@"07点",@"08点",@"09点",@"10点",@"11点",@"12点",@"13点",@"14点",@"15点",@"16点",@"17点",@"18点",@"19点",@"20点",@"21点",@"22点",@"23点"]];
        self.m_dayArray = [NSMutableArray arrayWithArray:@[@"00",@"10",@"20",@"30",@"40",@"50"]];

        self.m_mothcurArray = [NSMutableArray arrayWithArray:@[@"00点",@"01点",@"02点",@"03点",@"04点",@"05点",@"06点",@"07点",@"08点",@"09点",@"10点",@"11点",@"12点",@"13点",@"14点",@"15点",@"16点",@"17点",@"18点",@"19点",@"20点",@"21点",@"22点",@"23点"]];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM-dd"];
        NSString *dateTime = [formatter stringFromDate:[NSDate date]];
       
        [formatter setDateFormat:@"HH"];
        NSString *dateTimeHour = [formatter stringFromDate:[NSDate date]];
        
        NSInteger currentHour = dateTimeHour.integerValue;
        
        
        
        for (int i = 0; i < currentHour; i++) {
            [self.m_mothcurArray removeObjectAtIndex:0];
        }
        
        _row = 0;

        self.m_yearStr  = dateTime;
        
            self.m_monthStr = self.m_mothcurArray[0];
        
        self.m_dayStr = self.m_dayArray[0];
    
        self.pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 200, SCREEN_WIDTH, 200)];
        self.pickView.dataSource = self;
        self.pickView.delegate   = self;
        
        return self.pickView;
    }
    
    return _inputView;
}

//  inputAccessoryView 是 UIView即可,不一定非得是UIToolbar
- (UIToolbar *)inputAccessoryView {

    if (_inputAccessoryView == nil) {
        
        UIToolbar * toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        
        UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(btnResignFirstResponder)];
        toolBar.items = @[item];
        
        return toolBar;
    }
    
    return _inputAccessoryView;
}

- (void)btnResignFirstResponder {
    
    self.m_monthStr = [self.m_monthStr substringToIndex:self.m_monthStr.length - 1];
    [self setTitle:[NSString stringWithFormat:@"%@  %@:%@",self.m_yearStr,self.m_monthStr,self.m_dayStr] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self resignFirstResponder];
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {

    return 3;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
  

    if (component == 0) {
        
        return self.m_yearArray.count;
        
    } else if (component == 1) {
        
        if (self.row == 0) {
            return self.m_mothcurArray.count;
        }else {
        return self.m_monthArray.count;
        }
        
    }else
    
        return self.m_dayArray.count;
}

#pragma mark - UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    return SCREEN_WIDTH/3.0;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component __TVOS_PROHIBITED {
    
    return 40;
}


- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    
    if (component == 0) {
        
        return self.m_yearArray[row];
        
    } else if (component == 1) {
        if (self.row == 0) {
           
            return self.m_mothcurArray[row];
        }else {
            return self.m_monthArray[row];
        }

    }else
        
        return self.m_dayArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd"];
    //明天日期
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    NSDate *destDate = [formatter dateFromString:dateTime];
    NSString *tomorrow = [self GetTomorrowDay:destDate];
    if (component == 0) {
        if (row == 0) {
            self.m_yearStr = dateTime;
            self.row = row;
           
        }else {
            self.m_yearStr = tomorrow;
            self.row = row;
            self.m_monthStr = self.m_monthArray[0];
        }
        [self.pickView reloadAllComponents];
        
    } else if (component == 1) {
        if (_row == 0) {
            self.m_monthStr = self.m_mothcurArray[row];
        }else {
            self.m_monthStr = self.m_monthArray[row];
        }
        
    }else if (component == 2) {
        self.m_dayStr = self.m_dayArray[row];
    
    }
//    [self setTitle:[NSString stringWithFormat:@"%@  %@:%@",self.m_yearStr,self.m_monthStr,self.m_dayStr] forState:UIControlStateNormal];
    
    
    
}



- (NSString *)GetTomorrowDay:(NSDate *)aDate {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:aDate];
    [components setDay:([components day]+1)];
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:@"MM-dd"];
    return [dateday stringFromDate:beginningOfWeek];
}

@end
