//
//  BrandCell.h
//  FourServices
//
//  Created by admin on 2017/2/21.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrandModel.h"
#import "VehicledModel.h"

@interface BrandCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *photoImageView;
@property (strong, nonatomic) IBOutlet UILabel *brandLabel;
//-(void)setCellWithBrandDic:(NSDictionary *)dic;
//- (void)setModelCellWithDic:(NSDictionary *)dic;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imageWidth;
- (void)setCellWithVehicledModel:(VehicledModel *)model;

@end
