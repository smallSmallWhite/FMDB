//
//  BrandCell.m
//  FourServices
//
//  Created by admin on 2017/2/21.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "BrandCell.h"
#import "UIImageView+WebCache.h"

@implementation BrandCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
///设置品牌
-(void)setCellWithBrandDic:(NSDictionary *)dic{
//    
//    self.photoImageView.hidden = NO;
//    [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:dic[@"logo"]] placeholderImage:[UIImage imageNamed:@"baoma")];
//     self.brandLabel.text = dic[@"brandName"];
}
///设置型号
- (void)setModelCellWithDic:(NSDictionary *)dic{
    
    self.photoImageView.hidden = YES;
    self.imageWidth.constant = 0;
    self.brandLabel.textAlignment = NSTextAlignmentCenter;
    self.brandLabel.text = dic[@"modelName"];
}
-(void)setCellWithVehicledModel:(VehicledModel *)model{
    
//    self.photoImageView.backgroundColor = [UIColor redColor];
    self.photoImageView.image = [UIImage imageNamed:model.DVN_BRAND_LOGO];
    NSLog(@"---%@",model.DVN_BRAND_LOGO);
    self.brandLabel.text = model.DVN_BRAND;
}

@end
