//
//  YMAddressPickerView.m
//  YMPickerView
//
//  Created by youmy on 2018/3/16.
//  Copyright © 2018年 youmy. All rights reserved.
//

#import "YMAddressPickerView.h"
#import "MJExtension.h"

@interface YMAddressPickerView()<UIPickerViewDataSource, UIPickerViewDelegate>
@property(nonatomic, strong) UIPickerView *pickerView;

@property(nonatomic, strong) NSMutableArray *allProvinces;
@property(nonatomic, strong) NSMutableArray *allCitys;
@property(nonatomic, strong) NSMutableArray *allAreas;

@property(nonatomic, strong) NSMutableArray *datas;

@property(nonatomic, strong) YMProvince * currentProvince;
@property(nonatomic, strong) YMCity * currentCity;
@property(nonatomic, strong) YMArea * currentArea;

@property(nonatomic, assign) NSInteger firstIndex;
@property(nonatomic, assign) NSInteger secondIndex;
@property(nonatomic, assign) NSInteger thirdIndex;
@end

@implementation YMAddressPickerView

#pragma mark - Lazy

- (NSMutableArray *)allAreas{
    if (_allAreas == nil) {
        _allAreas = [NSMutableArray arrayWithArray:self.currentCity.arealist];
        self.currentArea = _allAreas.firstObject;
    }
    return _allAreas;
}

- (NSMutableArray *)allCitys{
    if (_allCitys == nil) {
        _allCitys = [NSMutableArray arrayWithArray:self.currentProvince.citylist];
        self.currentCity = _allCitys.firstObject;
    }
    return _allCitys;
}

- (NSMutableArray *)allProvinces{
    if (_allProvinces == nil) {
        NSString * path = [self addressPath];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSArray * array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        _allProvinces = [YMProvince mj_objectArrayWithKeyValuesArray:array];
        self.currentProvince = _allProvinces.firstObject;
        
        __block NSInteger areaCount = 0;
        
        [_allProvinces enumerateObjectsUsingBlock:^(YMProvince * province, NSUInteger idx, BOOL * _Nonnull stop) {
            [province.citylist enumerateObjectsUsingBlock:^(YMCity * city, NSUInteger idx, BOOL * _Nonnull stop) {
                areaCount += city.arealist.count;
            }];
        }];
        
        NSLog(@"全国区县数量：%ld",areaCount);
    }
    return _allProvinces;
}

- (NSMutableArray *)datas{
    if (_datas == nil) {
        _datas = [NSMutableArray arrayWithObjects:self.allProvinces, self.allCitys, self.allAreas, nil];
    }
    return _datas;
}

#pragma mark - Custorm
- (void)setSepratorColor:(UIColor *)sepratorColor{
    _sepratorColor = sepratorColor;
}

- (NSString *)addressPath{
    return [[NSBundle mainBundle] pathForResource:@"YMCity.json" ofType:nil];
}

- (void)colorWithLabel:(UILabel *)label component:(NSInteger)component row:(NSInteger)row{
    switch (component) {
        case 0:
        {
            if (_firstIndex == row) {
                label.textColor = [UIColor redColor];
            }else{
                label.textColor = [UIColor blackColor];
            }
        }
            break;
        case 1:
        {
            if (_secondIndex == row) {
                label.textColor = [UIColor redColor];
            }else{
                label.textColor = [UIColor blackColor];
            }
        }
            break;
        case 2:
        {
            if (_thirdIndex == row) {
                label.textColor = [UIColor redColor];
            }else{
                label.textColor = [UIColor blackColor];
            }
        }
            break;
            
        default:
            break;
    }
    
}

- (void)reloadComponent:(NSInteger)component{
    [self.pickerView reloadComponent:component];
    [self.pickerView selectRow:0 inComponent:component animated:YES];
}

#pragma mark - System

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 211, frame.size.width, 211)];
        bottomView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bottomView];
        
        UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(bottomView.frame.size.width - 80, 15, 60, 40)];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        btn.titleLabel.textColor = [UIColor redColor];
        [btn addTarget:self action:@selector(submmitBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:btn];
        
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 61, bottomView.bounds.size.width, 150)];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        [bottomView addSubview:_pickerView];
    }
    return self;
    
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.frame = [UIScreen mainScreen].bounds;
    
    self.pickerView.dataSource = self;
    
    self.pickerView.delegate = self;
    
    _firstIndex = 0;
    _secondIndex = 0;
    _thirdIndex = 0;
}

+ (YMAddressPickerView *)nibView{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}

- (void)submmitBtnAction:(UIButton *)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(pickerView:province:city:area:)]) {
        [_delegate pickerView:self province:self.currentProvince city:self.currentCity area:self.currentArea];
    }
}

#pragma mark - UIPickerViewDataSource, UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return self.datas.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSArray * arr = self.datas[component];
    return arr.count;
}

//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
//
//    NSArray * arr = self.datas[component];
//    NSDictionary * dic = arr[row];
//    NSString * title = [NSString stringWithFormat:@"%@",dic[@"divisionName"]];
//    return title;
//}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component == 0) {
        _currentProvince = self.datas[component][row];
        _firstIndex = row;
        
        __weak typeof(self) weakSelf = self;
        [self.allProvinces enumerateObjectsUsingBlock:^(YMProvince * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.uid isEqualToString:weakSelf.currentProvince.uid]){
                [weakSelf.allCitys removeAllObjects];
                weakSelf.allCitys = [NSMutableArray arrayWithArray:obj.citylist];
                weakSelf.currentCity = weakSelf.allCitys.firstObject;
                weakSelf.secondIndex = 0;
                [weakSelf.datas replaceObjectAtIndex:1 withObject:self.allCitys];
                [weakSelf reloadComponent:1];
            }
        }];
        
        _thirdIndex = 0;
        self.currentArea = self.currentCity.arealist.firstObject;
        [self.datas replaceObjectAtIndex:2 withObject:self.currentCity.arealist];
        [self reloadComponent:2];
        
    } else if (component == 1){
        self.currentCity = self.datas[component][row];
        _secondIndex = row;
        
        __weak typeof(self) weakSelf = self;
        [self.allCitys enumerateObjectsUsingBlock:^(YMCity * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.uid isEqualToString:weakSelf.currentCity.uid]){
                [weakSelf.allAreas removeAllObjects];
                weakSelf.allAreas = [NSMutableArray arrayWithArray:obj.arealist];
                weakSelf.thirdIndex = 0;
                weakSelf.currentArea = weakSelf.allAreas.firstObject;
                [weakSelf.datas replaceObjectAtIndex:2 withObject:weakSelf.allAreas];
                [weakSelf reloadComponent:2];
            }
        }];
        
    } else {
        self.currentArea = self.datas[component][row];
        _thirdIndex = row;
    }
    
    UILabel * label = (UILabel *)[pickerView viewForRow:row forComponent:component];
    [self colorWithLabel:label component:component row:row];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    //设置分割线的颜色
    
    for(UIView *singleLine in pickerView.subviews)
    {
        if (singleLine.frame.size.height < 1)
        {
            singleLine.backgroundColor = _sepratorColor;
            
        }
    }
    
    UILabel * label = [UILabel new];
    label.font = [UIFont boldSystemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    
    switch (component) {
        case 0:
        {
            YMProvince * province = self.datas[component][row];
            label.text = province.provinceName;
        }
        break;
        case 1:
        {
            YMCity * city = self.datas[component][row];
            label.text = city.cityName;
        }
        break;
        case 2:
        {
            YMArea * area = self.datas[component][row];
            label.text = area.areaName;
        }
        break;
        
        default:
        break;
    }

    [self colorWithLabel:label component:component row:row];
    return label;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 50;
}


@end
