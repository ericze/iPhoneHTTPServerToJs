//
//  AppDelegate.h
//  iPhoneHTTPServerToJs
//
//  Created by wangZL on 2017/5/29.
//  Copyright © 2017年 EricZe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTPServer.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) HTTPServer *localHttpServer;

@property (nonatomic,copy) NSString *port;


@end

