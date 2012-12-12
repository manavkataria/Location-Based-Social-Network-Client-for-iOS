//
//  AppDelegate.h
//  talklocaldev
//
//  Created by Manav Kataria on 12/3/12.
//  Copyright (c) 2012 Manav Kataria. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <FacebookSDK/FacebookSDK.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI;

@end

extern NSString *const FBSessionStateChangedNotification;
