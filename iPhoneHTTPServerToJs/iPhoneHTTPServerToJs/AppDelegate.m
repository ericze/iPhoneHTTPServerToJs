//
//  AppDelegate.m
//  iPhoneHTTPServerToJs
//
//  Created by wangZL on 2017/5/29.
//  Copyright © 2017年 EricZe. All rights reserved.
//

#import "AppDelegate.h"

#define webPath [[NSBundle mainBundle] pathForResource:@"Web" ofType:nil]

#define KSERVERURL @"http://pccdn.weshape3d.com"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
     [self configLocalHttpServer];
    // Override point for customization after application launch.
    return YES;
}

#pragma mark -- 本地服务器 --
#pragma mark -服务器
#pragma mark - 搭建本地服务器 并且启动
- (void)configLocalHttpServer{
    _localHttpServer = [[HTTPServer alloc] init];
    [_localHttpServer setType:@"_http.tcp"];
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSLog(@"%@",webPath);
    
    
    if (![fileManager fileExistsAtPath:webPath]){
        
        NSLog(@"File path error!");
    }else{
        NSString *webLocalPath = webPath;
        [_localHttpServer setDocumentRoot:webLocalPath];
        NSLog(@"webLocalPath:%@",webLocalPath);
        [self startServer];
    }
}
- (void)startServer
{
    
    NSError *error;
    if([_localHttpServer start:&error]){
        NSLog(@"Started HTTP Server on port %hu", [_localHttpServer listeningPort]);
        self.port = [NSString stringWithFormat:@"%d",[_localHttpServer listeningPort]];
    }
    else{
        NSLog(@"Error starting HTTP Server: %@", error);
    }
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


@end
