//
//  ViewController.m
//  review-Ordering system
//
//  Created by 张鸿懿 on 16/4/12.
//  Copyright © 2016年 initWithFxl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *pickView;
@property (weak, nonatomic) IBOutlet UILabel *fruitLable;

@property (weak, nonatomic) IBOutlet UILabel *drinkLabel;
@property (nonatomic, strong)NSArray *foods;
@property (weak, nonatomic) IBOutlet UILabel *mainFruitLable;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pickView.dataSource = self;
    self.pickView.delegate = self;
    
    for (int component = 0; component < self.foods.count; component++) {
        [self pickerView:nil didSelectRow:0 inComponent:component];
    }
    
}

/** 懒加载*/
- (NSArray *)foods
{
    if (_foods == nil) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"foods.plist" ofType:nil];
        _foods = [NSArray arrayWithContentsOfFile:filePath];
    }
    return _foods;
}

#pragma mark  pickView数据源方法
// 返回多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.foods.count;
}

// 返回第component列的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.foods[component] count];
}

#pragma mark  pickView代理方法
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.foods[component][row];
}

// 当pickView选中component列row行的时候就会调用以下方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:// 设置水果
            self.fruitLable.text = self.foods[component][row];
            break;
        case 1:// 设置主菜
            self.mainFruitLable.text = self.foods[component][row];
            break;
        case 2:// 设置饮料
            self.drinkLabel.text = self.foods[component][row];
            break;
    }
    NSLog(@"选中了第%ld第%ld行",component,row);
}

/** 随机选*/
- (IBAction)randomButton:(id)sender {
    for (int component = 0; component < self.foods.count; component++) {
        // 获取可选行数
        int count = (int)[self.foods[component] count];
        
        // 随机行号
        int row = arc4random_uniform(count);
        
        // 自动选中某一行
        [self.pickView selectRow:row inComponent:component animated:YES];
        
        // 主动给label更新
        [self pickerView:nil didSelectRow:row inComponent:component];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
