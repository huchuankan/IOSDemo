//
//  BaseTableViewController.m
//  ConnectorDemo
//
//  Created by huck on 2020/9/7.
//  Copyright © 2020 huck. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = colorForE9ECF0;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, KStatusNavBarHeight, KScreenWidth, KScreenHeight - KStatusNavBarHeight-Bottom34) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
    if (@available(iOS 11.0,*)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = false;
    }
    [self.view addSubview:_tableView];
    self.titleList = @[];
    self.dataList = @[];
}


#pragma mark - tableView代理 -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section > self.dataList.count - 1) {
        return 0;
    }
    NSArray *list = self.dataList[section];
    return list.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier =@"TableCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, 50 - 0.5, KScreenWidth-15, 0.5)];
        line.tag = 1;
        line.backgroundColor = [UIColor lightGrayColor];
        [cell.contentView addSubview:line];
    }
    NSArray* arr = self.dataList[indexPath.section];
    cell.tag = indexPath.section * 100 + indexPath.row + 101;
    cell.textLabel.text = arr[indexPath.row];
    UIView *line = (UIView *)[cell viewWithTag:1];
    line.hidden = indexPath.row == arr.count - 1;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(15, 0, KScreenWidth - 30 , 40)];
    UILabel *label = [[UILabel alloc] initWithFrame:view.frame];
    label.textColor = [UIColor redColor];
    label.text = self.titleList[section];
    label.font = [UIFont systemFontOfSize:12];
    [view addSubview:label];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self itemClick:cell.tag];
}

-(void)itemClick:(NSInteger)tag {
//    NSLog(@"去子类重写");
}

@end
