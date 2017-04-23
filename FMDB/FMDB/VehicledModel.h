//
//  VehicledModel.h
//  FourServices
//
//  Created by mac on 2017/4/15.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VehicledModel : NSObject
//品牌
@property (strong,nonatomic)NSString *DVN_BRAND;
//品牌id
@property (strong,nonatomic)NSString *DVN_ID;
//图片
@property (strong,nonatomic)NSString *DVN_BRAND_LOGO;
//英文标识
@property (strong,nonatomic)NSString *DVN_BRAND_ENGLISH;
//系列
@property (strong,nonatomic)NSString *DVN_SERIES;
//型号
@property (strong,nonatomic)NSString *DVN_TYPE;
//颜色
@property (strong,nonatomic)NSString *colorString;
//颜色图标
@property (strong,nonatomic)NSString *imaString;

@end
