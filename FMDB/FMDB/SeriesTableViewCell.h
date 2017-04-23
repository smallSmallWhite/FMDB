//
//  SeriesTableViewCell.h
//  FourServices
//
//  Created by mac on 2017/4/16.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FMDatabase.h>
#import "VehicledModel.h"

@interface SeriesTableViewCell : UITableViewCell

//系列label
@property (weak, nonatomic) IBOutlet UILabel *serieslabel;
//系列数量
@property (weak, nonatomic) IBOutlet UILabel *seriesCountLabel;
- (void)setSeriesCellWithModel:(VehicledModel *)model;
@end
