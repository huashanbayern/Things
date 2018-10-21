//
//  HSLRoute.m
//  Things
//
//  Created by LiHuashan on 2018/10/18.
//  Copyright © 2018 HuashanTech. All rights reserved.
//

#import "HSLRoute.h"
#import <UIKit/UIKit.h>

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

- (id)routingTargetForIdentifier:(NSString *)Identifier performSelector:(SEL)selector withArguments:(NSArray *)arguments {
    Class target = [self classForIdentifier:Identifier];
    return [self invokeWithTarget:target performSelector:selector withArguments:arguments];
}

//- (id)routingTarget:(Class)target performSelector:(SEL)selector withArguments:(NSArray *)arguments {
//    if (target && [self canRouteToTarget:target]) {
//        return [self invokeWithTarget:target performSelector:selector withArguments:arguments];
//    }
//    return nil;
//}

//- (id)routingController:(Class)cls performSelector:(SEL)selector withArguments:(NSArray *)arguments {
//    BOOL canControllerBeRouted = [self canRouteToController:cls];
//    if (canControllerBeRouted) {
//        if (selector) {
//            return [self invokeWithTarget:cls performSelector:selector withArguments:arguments];
//        } else {
//#warning 没有方法
//            return nil;
//        }
//    }
//    return nil;
//}

- (id)target:(Class)cls {
    return [self invokeWithTarget:cls selector:nil];
}

- (id)invokeWithTarget:(Class)cls selector:(SEL)selector {
    NSMethodSignature *methodSignature = [cls instanceMethodSignatureForSelector:selector];
    if (methodSignature) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
        id targetViewController = [[cls alloc] init];
        invocation.target = targetViewController;
        invocation.selector = selector;
        [[self getCurrentVC].navigationController pushViewController:targetViewController animated:YES];
        [invocation invoke];
        if (methodSignature.methodReturnLength) {
            id returnValue = nil;
            [invocation getReturnValue:&returnValue];
            return returnValue;
        }
    }
    return nil;
}




- (id)invokeWithTarget:(Class)target performSelector:(SEL)selector withArguments:(NSArray *)arguments {
    if (target && [self canRouteToTarget:target]) {
        id targetObj = [[target alloc] init];
        NSMethodSignature *methodSignature = [target instanceMethodSignatureForSelector:selector];
        if (methodSignature) {
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
            invocation.target = targetObj;
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
    
    return nil;
}

- (id)target:(id)targetObj selector:(SEL)selector arguments:(NSArray *)arguments {
    NSMethodSignature *methodSignature = [target instanceMethodSignatureForSelector:selector];
    if (methodSignature) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
        invocation.target = targetObj;
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

/*
 
 UIViewController *controllerBeingDisplaying = [self getCurrentVC];
 UINavigationController *currentNavigationController = controllerBeingDisplaying.navigationController;
 if (currentNavigationController) {
 [currentNavigationController pushViewController:targetObj animated:YES];
 } else {
 [controllerBeingDisplaying presentViewController:targetObj animated:YES completion:nil];
 }
 
 */


/*
 NSMethodSignature *methodSignature = [target instanceMethodSignatureForSelector:selector];
 if (methodSignature) {
 NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
 invocation.target = targetObj;
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
 //        [[self getCurrentVC] presentViewController:target animated:YES completion:nil];
 //        [[self getCurrentVC].navigationController pushViewController:targetObj animated:YES];
 [invocation invoke];
 if (methodSignature.methodReturnLength) {
 id returnValue = nil;
 [invocation getReturnValue:&returnValue];
 return returnValue;
 }
 }
 */

- (BOOL)canRouteToTarget:(Class)cls {
    return cls && [cls isSubclassOfClass:[UIViewController class]] && [self.routeMutableDictionary.allValues containsObject:cls];
}


- (BOOL)canRouteToController:(Class)cls {
    if (cls && [cls isSubclassOfClass:[UIViewController class]]) {
        if ([self.routeMutableDictionary.allValues containsObject:cls]) {
            return YES;
        }
    }
    return NO;
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

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC {
    UIViewController *result = nil;
    // 获取默认的window
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWindow in windows) {
            if (tmpWindow.windowLevel == UIWindowLevelNormal) {
                window = tmpWindow;
                break;
            }
        }
    }
    // 获取window的rootViewController
    result = window.rootViewController;
    
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    if ([result isKindOfClass:[UITabBarController class]]) {
        result = [(UITabBarController *)result selectedViewController];
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result visibleViewController];
    }
    return result;
}

//- (BOOL)isSubclassOfUIViewController {
//    NSUInteger lengthOfKey = key.length;
//    if (lengthOfKey) {
//        Class classForController = [self controllerForKey:key];
//        if (classForController) {
//            BOOL isSubclassOfUIViewController = [classForController isSubclassOfClass:NSClassFromString(@"UIViewController")];
//            if (isSubclassOfUIViewController) {
//                return YES;
//            }
//        }
//    }
//    return NO;
//}

- (void)registerClass:(NSString *)cls forIdentifier:(NSString *)identifier {
    BOOL isClsNSString = cls && [cls isKindOfClass:[NSString class]];
    if (isClsNSString) {
        cls = [cls stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSUInteger lengthOfCls = cls.length;
        if (lengthOfCls) {
            Class targetClass = NSClassFromString(cls);
            BOOL isTargetClassExisting = targetClass && ![targetClass isSubclassOfClass: [NSNull class]];
            if (isTargetClassExisting) {
                BOOL isContainsIdentifier = [self.routeMutableDictionary.allKeys containsObject:identifier];
                BOOL isContainsTargetClass = [self.routeMutableDictionary.allValues containsObject:targetClass];
                if (!isContainsTargetClass && !isContainsIdentifier) {
                    [self.routeMutableDictionary setValue:targetClass forKey:identifier];
                } else if (!isContainsIdentifier && isContainsTargetClass) {
                    NSAssert(!isContainsTargetClass, @"%@已被注册过路由，其路由标志为%@", targetClass, [self.routeMutableDictionary allKeysForObject:targetClass][0]);
                } else if (isContainsIdentifier && !isContainsTargetClass) {
                    NSAssert(!isContainsIdentifier, @"%@已被注册为%@的路由标志", identifier, self.routeMutableDictionary[identifier]);
                } else {
                    NSAssert(!(isContainsTargetClass&&isContainsIdentifier), @"<%@--%@>已被注册路由，无需重复注册", targetClass, identifier);
                }
            } else {
                NSAssert(isTargetClassExisting, @"被注册路由的类不存在");
            }
        } else {
            NSAssert(lengthOfCls, @"请检查实参cls的值是否正确");
        }
    } else { // nil、非NSString类
        NSAssert(isClsNSString, @"请检查实参cls的数据类型是否正确");
    }
    NSLog(@"路由字典1：%@", self.routeMutableDictionary);
}

- (Class)classForIdentifier:(NSString *)identifier {
    return [self.routeMutableDictionary valueForKey:identifier];
}

- (void)setController:(Class)cls forKey:(NSString *)key {
    BOOL isSubclsOfUIViewController = [cls isSubclassOfClass:NSClassFromString(@"UIViewController")];
    if (isSubclsOfUIViewController) {
        [self.routeMutableDictionary setValue:cls forKey:key];
    }
    NSLog(@"路由字典2：%@", self.routeMutableDictionary);
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
