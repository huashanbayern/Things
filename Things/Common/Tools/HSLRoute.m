//
//  HSLRoute.m
//  Things
//
//  Created by LiHuashan on 2018/10/18.
//  Copyright © 2018 HuashanTech. All rights reserved.
//

#import "HSLRoute.h"

@interface HSLRoute ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, Class> *routeMutableDictionary;

@end

@implementation HSLRoute

+ (instancetype)sharedRoute {
    static HSLRoute *sharedRoute = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedRoute = [[[self class] alloc] init];
    });
    
    return sharedRoute;
}

- (BOOL)canRouteToControllerForKey:(NSString *)key {
    NSUInteger lengthOfKey = key.length;
    if (lengthOfKey) {
        Class classForController = [self controllerForKey:key];
        BOOL isUIViewControllerClass = [classForController isSubclassOfClass:NSClassFromString(@"UIViewController")];
        if (classForController && isUIViewControllerClass) {
            return YES;
        }
    }
    return NO;
}

- (void)setController:(Class)cls forKey:(NSString *)key {
    [self.routeMutableDictionary setValue:cls forKey:key];
}

- (Class)controllerForKey:(NSString *)key {
    return [self.routeMutableDictionary valueForKey:key];
}

- (NSMutableDictionary *)routeMutableDictionary {
    if (!_routeMutableDictionary) {
        _routeMutableDictionary = [NSMutableDictionary dictionary];
    }
    return _routeMutableDictionary;
}

@end
