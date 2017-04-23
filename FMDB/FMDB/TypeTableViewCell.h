//
//  TypeTableViewCell.h
//  FourServices
//
//  Created by mac on 2017/4/16.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VehicledModel.h"
@interface TypeTableViewCell : UITableViewCell
//车辆类型label
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
- (void)setCellWithModel:(VehicledModel *)model;
@end
