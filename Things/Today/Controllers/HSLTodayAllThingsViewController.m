//
//  HSLTodayAllThingsViewController.m
//  Things
//
//  Created by LiHuashan on 2018/10/17.
//  Copyright © 2018 HuashanTech. All rights reserved.
//

#import "HSLTodayAllThingsViewController.h"
#import "HSLRoute.h"

@interface HSLTodayAllThingsViewController ()

@end

@implementation HSLTodayAllThingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"2018-09-06";
    self.view.backgroundColor = [UIColor blueColor];
    static NSString * const key = @"hsl_today_all_things_view_controller";
    static NSString * const key1 = @"hsl_mine_view_controller";
    //[[HSLRoute sharedRoute] setController:self.class forKey:key];
    
    NSString *str = [@"     d   d  d" stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSLog(@"str===%lu", str.length);
    
    Class cls = NSClassFromString(@"HSLEnglish");
    NSLog(@"目标1：%@", cls);
    Class cls2 = NSClassFromString(@" ");
    NSLog(@"目标2：%@", cls2);
    
    Class cls3 = NSClassFromString(@"HSLThingsAppTabBarController");
    NSLog(@"目标3：%@", cls3);
    
    NSLog(@"字符个数：%lu", @"".length);

    [[HSLRoute sharedRoute] registerClass:@"HSLTodayAllThingsViewController" forIdentifier:key];
    [[HSLRoute sharedRoute] registerClass:@"HSLMineViewController" forIdentifier:key1];
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
