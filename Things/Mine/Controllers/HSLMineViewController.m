//
//  HSLMineViewController.m
//  Things
//
//  Created by LiHuashan on 2018/10/17.
//  Copyright © 2018 HuashanTech. All rights reserved.
//

#import "HSLMineViewController.h"
#import "HSLRoute.h"

@interface HSLMineViewController ()

@end

@implementation HSLMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    static NSString * const key = @"today_all_things_view_controller";
    BOOL canRoute = [[HSLRoute sharedRoute] canRouteToControllerForKey: key];
    NSLog(@"是否能路由：%d", canRoute);
    [[HSLRoute sharedRoute] routeToControllerWithKey:key selector:@selector(todayWithNum: string:) arguments:@[@(123), @"0000", @(345)]];
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
