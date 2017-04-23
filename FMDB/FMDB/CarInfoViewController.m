//
//  CarInfoViewController.m
//  FourServices
//
//  Created by mac on 2017/4/15.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "CarInfoViewController.h"
#import <FMDatabase.h>
#import "SendBoxPath.h"
#import "VehicledModel.h"
#import "BrandCell.h"
#import "SeriesViewController.h"

static NSString *const brandCell = @"BrandCell";
@interface CarInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
//存放所有数据的模型
@property (strong,nonatomic) NSMutableArray *dataSource;
//存放所有键的数组
@property (strong,nonatomic) NSMutableArray *keysArray;
//创建可变字典
@property (strong,nonatomic) NSMutableDictionary *mDic;
@property (strong,nonatomic) UITableView *tableView;
@end

@implementation CarInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingView];
    [self loadData];
}
#pragma mark 初始化设置
- (void)settingView{
    
    self.navigationItem.title = @"选择品牌";
    self.view.backgroundColor = [UIColor redColor];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:38/255.0 green:38/255.0 blue:38/255.0 alpha:1.0]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(clickBack:)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    

    
    //初始化tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:(UITableViewStyleGrouped)];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    //注册cell
     [_tableView registerNib:[UINib nibWithNibName:@"BrandCell" bundle:nil] forCellReuseIdentifier:brandCell];
}
#pragma mark 数据请求
- (void)loadData{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Vehicle_DICT (1)" ofType:@"db"];
    FMDatabase *dataBase = [FMDatabase databaseWithPath:path];
    [dataBase open];
    FMResultSet *result = [dataBase executeQuery:@"select distinct DVN_BRAND, DVN_BRAND_LOGO, DVN_BRAND_ENGLISH from DICT_VEHICLE_NEW order by DVN_BRAND_ENGLISH ASC;"];
    while ([result next]) {
        
        VehicledModel *model = [[VehicledModel alloc] init];
        model.DVN_BRAND = [result objectForColumnName:@"DVN_BRAND"];
        model.DVN_BRAND_ENGLISH = [result objectForColumnName:@"DVN_BRAND_ENGLISH"];
        NSString *logoImage = [[result objectForColumnName:@"DVN_BRAND_LOGO"] stringByReplacingOccurrencesOfString:@"/Content/Images/carbrand/" withString:@""];
//        NSString *logoImage = [result objectForColumnName:@"DVN_BRAND_LOGO"];
        model.DVN_BRAND_LOGO = logoImage;
        [self.dataSource addObject:model];
        
    }
    //获取26个字母，将其保存到数组中
    for (char ch = 'A'; ch <= 'Z'; ch++) {
        
        //添加到key的数组
        NSString *key =[NSString stringWithFormat:@"%c",ch];
        //添加到数组
        [self.keysArray addObject:key];
        //创建可变的数组
        NSMutableArray *mArr =[[NSMutableArray alloc] init];
        //把26个字母作为键值 添加可变数组对象到可变字典中
        [self.mDic setObject:mArr forKey:key];
    }
    //添加#到存放键的数组中
    NSMutableArray *mArr =[NSMutableArray new];
    NSString *jing = @"#";
    [self.keysArray  addObject:jing];
    [self.mDic setObject:mArr forKey:jing];
   
    for (int i = 0; i < self.keysArray.count;i++) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        NSString *key = self.keysArray[i];
        for (int j = 0; j < self.dataSource.count; j++) {
          
             VehicledModel *model = self.dataSource[j];
            if (![model.DVN_BRAND_ENGLISH isKindOfClass:[NSNull class]]) {
                
                if ([key isEqualToString:model.DVN_BRAND_ENGLISH]) {
                    
                    [array addObject:model];
                }
            }
           
        }
        [self.mDic setObject:array forKey:key];
    }
    //判断没有车系的分类要删除
    for (NSString *key in self.mDic.allKeys)
    {
        //获取key下的数组
        NSMutableArray *mArrCity =self.mDic[key];
        //判断个数小于1是空的
        if (mArrCity.count<1)
        {
            //数组
            [self.keysArray removeObject:key];
            //字典
            [self.mDic removeObjectForKey:key];
            //跳过
            continue;
        }
    }
    [self.tableView reloadData];
    
}
//section的titleHeader
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.keysArray objectAtIndex:section];
}
//section行数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.keysArray count];
}
//每组section个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSMutableArray *array = [self.mDic objectForKey:self.keysArray[section]];
    return array.count;
}
//section右侧index数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.keysArray;
}
//点击右侧索引表项时调用 索引与section的对应关系
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index;
}
//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BrandCell *cell = [tableView dequeueReusableCellWithIdentifier:brandCell forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    NSMutableArray *array = self.mDic[self.keysArray[indexPath.section]];
    VehicledModel *model = array[indexPath.row];
    [cell setCellWithVehicledModel:model];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 56;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 15;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableArray *array = self.mDic[self.keysArray[indexPath.section]];
    VehicledModel *model = array[indexPath.row];
    SeriesViewController *vc = [[SeriesViewController alloc] init];
    vc.DVN_BRAND = model.DVN_BRAND;
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark 返回按钮
- (void)clickBack:(UIBarButtonItem *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 懒加载
- (NSMutableArray *)dataSource{
    
    if (!_dataSource) {
        
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}
-(NSMutableArray *)keysArray{
    
    if (!_keysArray) {
        
        _keysArray = [[NSMutableArray alloc] init];
    }
    return _keysArray;
}
-(NSMutableDictionary *)mDic{
    
    if (!_mDic) {
        
        _mDic = [NSMutableDictionary dictionary];
    }
    return _mDic;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
