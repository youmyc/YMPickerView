# YMPickerView

Just download the project, and drag and drop the "YMPickerView/YMPicker" folder in your project.

```objc
#import "YMAddressPickerView.h"

- (YMAddressPickerView *)addressV{
    if (_addressV == nil) {
        _addressV = [YMAddressPickerView nibView];
        _addressV.delegate = self;
        _addressV.sepratorColor = [UIColor lightGrayColor];
    }
    return _addressV;
}

#pragma mark - GZAZJAddressPickerViewDelegate
- (void)pickerView:(YMAddressPickerView *)view province:(YMProvince *)province city:(YMCity *)city area:(YMArea *)area{
    [_addressV removeFromSuperview];
    _addressTF.text = [[NSString alloc] initWithFormat:@"%@ %@ %@",province.provinceName,city.cityName, area.areaName];
}
```

## 效果
![](https://github.com/youmyc/YMPickerView/blob/master/addressPicker.gif)
![](https://gitee.com/yom/YMPickerView/raw/master/addressPicker.gif)

## Author

* Email:260903229@qq.com
* Wechat:260903229
