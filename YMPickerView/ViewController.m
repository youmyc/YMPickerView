//
//  ViewController.m
//  YMPickerView
//
//  Created by mac on 2019/1/18.
//  Copyright © 2019 youmy. All rights reserved.
//

#import "ViewController.h"
#import "YMAddressPickerView.h"

@interface ViewController ()<GZAZJAddressPickerViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property(strong, nonatomic) YMAddressPickerView * addressV;
@end

@implementation ViewController

- (YMAddressPickerView *)addressV{
    if (_addressV == nil) {
        _addressV = [YMAddressPickerView nibView];
        _addressV.delegate = self;
        _addressV.sepratorColor = [UIColor lightGrayColor];
    }
    return _addressV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _addressTF.delegate = self;
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self.view.window addSubview:self.addressV];
    return NO;
}

#pragma mark - GZAZJAddressPickerViewDelegate
- (void)pickerView:(YMAddressPickerView *)view province:(YMProvince *)province city:(YMCity *)city area:(YMArea *)area{
    [_addressV removeFromSuperview];
    _addressTF.text = [[NSString alloc] initWithFormat:@"%@ %@ %@",province.provinceName,city.cityName, area.areaName];
}

@end
