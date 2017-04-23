//
//  TypeTableViewCell.m
//  FourServices
//
//  Created by mac on 2017/4/16.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "TypeTableViewCell.h"

@implementation TypeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setCellWithModel:(VehicledModel *)model{
    
    self.typeLabel.text = model.DVN_TYPE;
}

@end
