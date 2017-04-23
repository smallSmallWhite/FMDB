//
//  SeriesViewController.m
//  FourServices
//
//  Created by mac on 2017/4/16.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "SeriesViewController.h"
#import <FMDatabase.h>
#import "VehicledModel.h"
#import "SeriesTableViewCell.h"
#import "CarTypeViewController.h"

static NSString *const seriesTableViewCell = @"SeriesTableViewCell";
@interface SeriesViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)UITableView *tableView;
@property (strong,nonatomic)NSMutableArray *dataSource;
@end

@implementation SeriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingView];
    [self loadData];
}
#pragma mark 初始化设置
- (void)settingView{
    
    self.navigationItem.title = @"选择车系";
    self.view.backgroundColor = [UIColor redColor];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:38/255.0 green:38/255.0 blue:38/255.0 alpha:1.0]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(clickBack:)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
    //初始化tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:(UITableViewStylePlain)];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    //注册cell
    [_tableView registerNib:[UINib nibWithNibName:@"SeriesTableViewCell" bundle:nil] forCellReuseIdentifier:seriesTableViewCell];
}
#pragma mark 数据处理
- (void)loadData{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Vehicle_DICT (1)" ofType:@"db"];
    FMDatabase *dataBase = [FMDatabase databaseWithPath:path];
    [dataBase open];
    NSString *queryString = [NSString stringWithFormat:@"select distinct DVN_SERIES,DVN_BRAND from DICT_VEHICLE_NEW where DVN_BRAND='%@' order by DVN_SERIES asc",_DVN_BRAND];
    FMResultSet *result = [dataBase executeQuery:queryString];
    while ([result next]) {
        
        VehicledModel *model = [[VehicledModel alloc] init];
        model.DVN_SERIES = [result objectForColumnName:@"DVN_SERIES"];
        model.DVN_BRAND = [result objectForKeyedSubscript:@"DVN_BRAND"];
        [self.dataSource addObject:model];
    }
    [self.tableView reloadData];
    
}
//每组section个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}
//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SeriesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:seriesTableViewCell forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    VehicledModel *model = self.dataSource[indexPath.row];
    [cell setSeriesCellWithModel:model];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 56;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    VehicledModel *model = self.dataSource[indexPath.row];
    CarTypeViewController *vc = [[CarTypeViewController alloc] init];
    vc.vehicledModel = model;
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
