//
//  AppDelegate.m
//  FlickrTest
//
//  Created by ASH on 10/17/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "AppDelegate.h"

#import "SAPFlickrCollectionViewController.h"

#import "UIWindow+SAPExtensions.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [UIWindow window];
    self.window = window;
    window.rootViewController = [SAPFlickrCollectionViewController new];;
    [window makeKeyAndVisible];
    
    return YES;
}

@end
