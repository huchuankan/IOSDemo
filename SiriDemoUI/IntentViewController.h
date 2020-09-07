
//
//  IntentViewController.h
//  SiriDemoUI
//
//  Created by huck on 2020/9/4.
//  Copyright © 2020 huck. All rights reserved.
//

#import <IntentsUI/IntentsUI.h>

@interface IntentViewController : UIViewController <INUIHostedViewControlling>

@property (weak, nonatomic) IBOutlet UILabel *siriTitle;
@property (weak, nonatomic) IBOutlet UIButton *btn;
- (IBAction)btnclick:(UIButton *)sender;


@end
