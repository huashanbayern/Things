//
//  HSLRoute.h
//  Things
//
//  Created by LiHuashan on 2018/10/18.
//  Copyright © 2018 HuashanTech. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSLRoute : NSObject

+ (instancetype)sharedRoute;

- (id)routeToControllerWithKey:(NSString *)key selector:(SEL)selector arguments:(NSArray *)arguments;
- (BOOL)canRouteToControllerForKey:(NSString *)key;
- (void)setController:(Class)cls forKey:(NSString *)key;
- (void)registerClass:(nullable NSString *)cls forIdentifier:(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
