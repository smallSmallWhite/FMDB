//
//  SendBoxPath.h
//  Lesson_Sendbox
//
//  Created by admin on 16/3/7.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SendBoxPath : NSObject

//获得documents文件夹路径
+ (NSString *)documentsPath;
//获得library的文件路径
+ (NSString *)libraryPath;
//回去tmp文件路径
+ (NSString *)tmpPath;
//获取cache文件路径
+ (NSString *)cachesPath;

@end
