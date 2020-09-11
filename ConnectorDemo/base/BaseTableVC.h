//
//  BaseTableVC.h
//  ConnectorDemo
//
//  Created by huck on 2020/9/7.
//  Copyright © 2020 huck. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableVC : BaseVC

@property (strong, nonatomic) UITableView *tableView;
@property (copy,nonatomic) NSArray *titleList;
@property (copy,nonatomic) NSArray *dataList;

@end

NS_ASSUME_NONNULL_END
