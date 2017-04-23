//
//  SeriesTableViewCell.m
//  FourServices
//
//  Created by mac on 2017/4/16.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "SeriesTableViewCell.h"

@implementation SeriesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setSeriesCellWithModel:(VehicledModel *)model{
    
    self.serieslabel.text = model.DVN_SERIES;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Vehicle_DICT (1)" ofType:@"db"];
    FMDatabase *dataBase = [FMDatabase databaseWithPath:path];
    [dataBase open];
    NSString *queryString = [NSString stringWithFormat:@"select DVN_ID,DVN_TYPE from DICT_VEHICLE_NEW where DVN_SERIES='%@' and DVN_BRAND='%@'  order by DVN_TYPE asc",model.DVN_SERIES,model.DVN_BRAND];
    FMResultSet *result = [dataBase executeQuery:queryString];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    while ([result next]) {
        
        VehicledModel *model = [[VehicledModel alloc] init];
        model.DVN_ID = [result objectForColumnName:@"DVN_ID"];
        [array addObject:model];
    }
    self.seriesCountLabel.text = [NSString stringWithFormat:@"%lu个车型",(unsigned long)array.count];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
