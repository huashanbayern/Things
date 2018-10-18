//
//  HSLThingsAppTabBarController.m
//  Things
//
//  Created by LiHuashan on 2018/10/17.
//  Copyright © 2018 HuashanTech. All rights reserved.
//

#import "HSLThingsAppTabBarController.h"
#import "HSLThingsAppNavigationController.h"
#import "HSLTodayAllThingsViewController.h"
#import "HSLMineViewController.h"

@interface HSLThingsAppTabBarController ()

@end

@implementation HSLThingsAppTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addChildViewControllers];
}

- (void)addChildViewControllers {
    HSLTodayAllThingsViewController *todayAllThingsViewController = [[HSLTodayAllThingsViewController alloc] init];
    [todayAllThingsViewController configureTabBarItemWithTitle:@"今天" image:nil selectedImage:nil];
    
    HSLMineViewController *mineViewController = [[HSLMineViewController alloc] init];
    [mineViewController configureTabBarItemWithTitle:@"我的" image:nil selectedImage:nil];
    
    NSArray<__kindof UIViewController *>  *viewControllers = @[todayAllThingsViewController, mineViewController];
    self.viewControllers = viewControllers;
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
