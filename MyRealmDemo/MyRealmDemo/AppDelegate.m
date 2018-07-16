//
//  AppDelegate.m
//  MyRealmDemo
//
//  Created by 蔡成汉 on 2018/7/16.
//  Copyright © 2018年 蔡成汉. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self configRealm];
    
    MainViewController *controller = [[MainViewController alloc]init];
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:controller];
    self.window.rootViewController = navigationController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)configRealm {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *realmPath = [NSString stringWithFormat:@"%@/default.realm",path];
    NSLog(@"数据库路径：%@",realmPath);
    
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    NSInteger currentSchemaVersion = 3;
    config.schemaVersion = currentSchemaVersion;
    config.migrationBlock = ^(RLMMigration * _Nonnull migration, uint64_t oldSchemaVersion) {
        if (oldSchemaVersion < currentSchemaVersion) {
            NSLog(@"执行数据库升级");
        }
    };
    [RLMRealmConfiguration setDefaultConfiguration:config];
    [RLMRealm defaultRealm];
}

@end
