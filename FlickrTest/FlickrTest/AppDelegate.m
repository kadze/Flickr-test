//
//  AppDelegate.m
//  FlickrTest
//
//  Created by ASH on 10/17/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "AppDelegate.h"

#import "SAPFlickrCollectionViewController.h"
#import "SAPArrayModel.h"

#import "UIWindow+SAPExtensions.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [UIWindow window];
    self.window = window;
    SAPFlickrCollectionViewController *controller = [SAPFlickrCollectionViewController new];
    controller.model = [SAPArrayModel new];
    window.rootViewController = controller;
    [window makeKeyAndVisible];
    
    return YES;
}

@end
