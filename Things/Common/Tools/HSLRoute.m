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

- (id)routeWithKey:(NSString *)key selector:(SEL)selector arguments:(NSArray *)arguments {
    BOOL canRoute = [self canRouteToControllerForKey:key];
    if (canRoute) {
        Class classForController = [self controllerForKey:key];
        if (selector) {
            NSMethodSignature *methodSignature = [classForController instanceMethodSignatureForSelector:selector];
            if (methodSignature) {
                NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
                id targetViewController = [[classForController alloc] init];
                invocation.target = targetViewController;
                invocation.selector = selector;
                if (arguments) {
                    NSUInteger countOfArgumentsInArgumentsArray = arguments.count;
                    if (countOfArgumentsInArgumentsArray) {
                        NSUInteger numberOfArgumentsInMethodSignature = methodSignature.numberOfArguments - 2;
                        NSUInteger countOfArguments = MIN(numberOfArgumentsInMethodSignature, countOfArgumentsInArgumentsArray);
                        if (countOfArguments) {
                            [arguments enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                if (idx+1 <= countOfArguments) {
                                    [invocation setArgument:&obj atIndex:idx+2];
                                } else {
                                    *stop = YES;
                                }
                            }];
                        }
                    }
                }
                [invocation invoke];
                if (methodSignature.methodReturnLength) {
                    id returnValue = nil;
                    [invocation getReturnValue:&returnValue];
                    return returnValue;
                }
            }
        }
    }
    return nil;
}

- (BOOL)canRouteToControllerForKey:(NSString *)key {
    return [self isSubclassOfUIViewControllerForKey:key];
}

- (BOOL)isSubclassOfUIViewControllerForKey:(NSString *)key {
    NSUInteger lengthOfKey = key.length;
    if (lengthOfKey) {
        Class classForController = [self controllerForKey:key];
        if (classForController) {
            BOOL isSubclassOfUIViewController = [classForController isSubclassOfClass:NSClassFromString(@"UIViewController")];
            if (isSubclassOfUIViewController) {
                return YES;
            }
        }
    }
    return NO;
}

- (void)setController:(Class)cls forKey:(NSString *)key {
    [self.routeMutableDictionary setValue:cls forKey:key];
    NSLog(@"路由字典：%@", self.routeMutableDictionary);
}

//- (id)controllerForKey:(NSString *)key {
//    Class classForController = [self.routeMutableDictionary valueForKey:key];
//    id targetViewController = [[classForController alloc] init];
//    return targetViewController;
//}

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
