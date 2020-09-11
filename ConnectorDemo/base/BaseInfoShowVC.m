//
//  BaseInfoShowViewController.m
//  ConnectorDemo
//
//  Created by huck on 2020/9/11.
//  Copyright © 2020 huck. All rights reserved.
//

#import "BaseInfoShowVC.h"

@interface BaseInfoShowVC ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btn1;

@property (weak, nonatomic) IBOutlet UIButton *btn2;

@property (weak, nonatomic) IBOutlet UITextView *infoView;

@end

@implementation BaseInfoShowVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.infoView.layer.cornerRadius = 10;
    self.infoView.layer.masksToBounds = YES;
    self.infoView.layer.borderColor = [UIColor grayColor].CGColor;
    self.infoView.layer.borderWidth = 2;
    self.infoView.textContainerInset = UIEdgeInsetsMake(15, 10, 15, 10);
    self.infoView.delegate = self;
    self.infoView.editable = NO;
    
    [self.btn1 addTarget:self action:@selector(clickBtn1) forControlEvents:UIControlEventTouchUpInside];
    [self.btn2 addTarget:self action:@selector(clickBtn2) forControlEvents:UIControlEventTouchUpInside];
}


- (void)textViewDidChange:(UITextView *)textView {

    //防止输入时在中文后输入英文过长直接中文和英文换行
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    NSDictionary *attributes = @{
        NSFontAttributeName:[UIFont systemFontOfSize:14],
        NSParagraphStyleAttributeName:paragraphStyle
    };
    
    textView.attributedText = [[NSAttributedString alloc] initWithString:textView.text attributes:attributes];
}


- (void)setBtn1Name:(NSString *)name {
    if (name) {
        [self.btn1 setTitle:name forState:UIControlStateNormal];
    }
}
- (void)setBtn2Name:(NSString *)name {
    if (name) {
        [self.btn2 setTitle:name forState:UIControlStateNormal];
    }
}
- (void)hideBtn2:(BOOL)isHide {
    self.btn2.hidden = isHide;
}

- (void)setInfo:(NSString *)info {
    self.infoView.text = info;
}


- (void)clickBtn2 {
}

- (void)clickBtn1 {
}

@end

