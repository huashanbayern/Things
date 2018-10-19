//
//  HSLTodayAllThingsViewController.m
//  Things
//
//  Created by LiHuashan on 2018/10/17.
//  Copyright © 2018 HuashanTech. All rights reserved.
//

#import "HSLTodayAllThingsViewController.h"

@interface HSLTodayAllThingsViewController ()

@end

@implementation HSLTodayAllThingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"2018-09-06";
}

- (void)todayWithNum:(NSNumber *)num string:(NSString *)string {
    NSLog(@"参数：%@--%@", num, string);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
