//
//  YMRegionalism.m
//  YMPickerView
//
//  Created by youmy on 2018/3/19.
//  Copyright © 2018年 youmy. All rights reserved.
//

#import "YMRegionalism.h"
#import "MJExtension.h"

@implementation YMRegionalism

@end

@implementation YMArea

@end

@implementation YMCity
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"arealist":@"YMArea"};
}
@end

@implementation YMProvince
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"citylist":@"YMCity"};
}
@end
