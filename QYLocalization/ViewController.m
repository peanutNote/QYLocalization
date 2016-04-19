//
//  ViewController.m
//  QYLocalization
//
//  Created by qianye on 16/4/18.
//  Copyright © 2016年 qianye. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *tip = NSLocalizedString(@"Tip", @"dialog title");
    NSString *ok = NSLocalizedString(@"Ok", @"dialog button");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Tip", @"dialog title") message:NSLocalizedString(@"Please input your userName", @"message") delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"dialog button") otherButtonTitles:nil, nil];
    [alertView show];
}
@end
