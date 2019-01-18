//
//  YMRegionalism.h
//  YMPickerView
//
//  Created by youmy on 2018/3/19.
//  Copyright © 2018年 youmy. All rights reserved.
//  省、市、区模型

#import <Foundation/Foundation.h>

@interface YMRegionalism : NSObject

@end

@interface YMArea : NSObject
@property (nonatomic, strong) NSString * areaName;
@property (nonatomic, strong) NSString * uid;
@end

@interface YMCity : NSObject
@property (nonatomic, strong) NSArray * arealist;
@property (nonatomic, strong) NSString * cityName;
@property (nonatomic, strong) NSString * uid;
@end

@interface YMProvince : NSObject
@property (nonatomic, strong) NSArray * citylist;
@property (nonatomic, strong) NSString * uid;
@property (nonatomic, strong) NSString * provinceName;
@end
