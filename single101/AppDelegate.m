//
//  AppDelegate.m
//  single101
//
//  Created by Manav Kataria on 12/3/12.
//  Copyright (c) 2012 Manav Kataria. All rights reserved.
//

#import "AppDelegate.h"
#import "FeedTableViewController.h"
#import "ProfileViewController.h"


void uncaughtExceptionHandler(NSException *exception) {
    NSLog(@"CRASH: %@", exception);
    NSLog(@"Stack Trace: %@", [exception callStackSymbols]);
    // Internal error reporting
}


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //Use Exception Handler to Throw a Better Stack Trace.
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    
    FeedTableViewController *feedTableViewController = [[FeedTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    UINavigationController *feedNavController = [[UINavigationController alloc] initWithRootViewController:feedTableViewController];
    
    //ProfileViewController *profileViewController = [[ProfileViewController alloc] init];
    //UINavigationController *profileNavController = [[UINavigationController alloc] initWithRootViewController:profileViewController];

    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    [tabBarController setViewControllers:@[feedNavController]];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    
    //CGRect viewRect = [[UIScreen mainScreen] bounds];
    //NSLog(@"Screen is %f tall and %f wide", viewRect.size.height, viewRect.size.width);
    
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
