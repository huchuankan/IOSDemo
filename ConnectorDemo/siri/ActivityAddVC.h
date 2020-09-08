//
//  ActivityAddVC.h
//  ConnectorDemo
//
//  Created by huck on 2020/9/8.
//  Copyright © 2020 huck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ActivityAddVC : BaseTableViewController

@property (weak, nonatomic) IBOutlet UILabel *label;

- (IBAction)addActivity:(UIButton *)sender;

@end


NS_ASSUME_NONNULL_END
