//
//  HSLThingsAppBaseViewController.m
//  Things
//
//  Created by LiHuashan on 2018/10/17.
//  Copyright © 2018 HuashanTech. All rights reserved.
//

#import "HSLThingsAppBaseViewController.h"

@interface HSLThingsAppBaseViewController ()

@end

@implementation HSLThingsAppBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureSelf];
}

- (void)configureSelf {
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)configureTabBarItemWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)seletedImage {
    self.tabBarItem.title = title;
    self.tabBarItem.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem.selectedImage = [seletedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

//- (void)configureTabBarItemWithTitle:(NSString *)title image:(UIImage *)image tag:(NSInteger)tag {
////    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:image tag:tag];
//    self.tabBarItem.title = title;
//    self.tabBarItem.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    self.tabBarItem.tag = tag;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
