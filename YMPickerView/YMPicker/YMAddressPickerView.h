//
//  YMAddressPickerView.h
//  YMPickerView
//
//  Created by youmy on 2018/3/16.
//  Copyright © 2018年 youmy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMRegionalism.h"

@class YMAddressPickerView;
@protocol GZAZJAddressPickerViewDelegate <NSObject>
- (void)pickerView:(YMAddressPickerView *)view province:(YMProvince *)province city:(YMCity *)city area:(YMArea *)area;
@end

@interface YMAddressPickerView : UIView
@property(nonatomic, weak) id <GZAZJAddressPickerViewDelegate> delegate;
+ (YMAddressPickerView *)nibView;

/** 分隔线颜色*/
@property(nonatomic, strong) UIColor * sepratorColor;
@end
