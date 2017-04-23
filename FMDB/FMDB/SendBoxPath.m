//
//  SendBoxPath.m
//  Lesson_Sendbox
//
//  Created by admin on 16/3/7.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SendBoxPath.h"

@implementation SendBoxPath

+(NSString *)documentsPath{
    
    NSArray *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsStr = [documentsPath objectAtIndex:0];
    return documentsStr;
}
+(NSString *)libraryPath{
    
    NSArray *libraryPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    
    return [[libraryPath objectAtIndex:0] stringByAppendingPathComponent:@"Caches"];
}
+(NSString *)tmpPath{
    
    NSString *tmpPathStr = NSTemporaryDirectory();
    return tmpPathStr;
}
+(NSString *)cachesPath{
    
    NSArray *cachePathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [cachePathArray objectAtIndex:0];
}

@end
