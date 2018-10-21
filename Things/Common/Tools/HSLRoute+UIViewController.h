//
//  HSLRoute+UIViewController.h
//  Things
//
//  Created by LiHuashan on 2018/10/21.
//  Copyright © 2018 HuashanTech. All rights reserved.
//

#import "HSLRoute.h"

typedef NS_ENUM(NSUInteger, HSLRouteDisplayingControllerWay) {
    HSLRouteDisplayingControllerWayPush = 0,
    HSLRouteDisplayingControllerWayPresent
};

NS_ASSUME_NONNULL_BEGIN

@interface HSLRoute (UIViewController)

- (id)routeToViewControllerForIdentifier:(NSString *)identifier
                           displayingWay:(HSLRouteDisplayingControllerWay)displayingWay
                                animated:(BOOL)animated
                         performSelector:(SEL)selector
                           withArguments:(NSArray *)arguments;

@end

NS_ASSUME_NONNULL_END
