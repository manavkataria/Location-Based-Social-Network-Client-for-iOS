//
//  LoginViewController.m
//  talklocaldev
//
//  Created by Manav Kataria on 12/12/12.
//  Copyright (c) 2012 Manav Kataria. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    CGRect viewRect = [[UIScreen mainScreen] bounds];
    UIView *view = [[UIView alloc] initWithFrame:viewRect];
    
    self.view = view;
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self createTitleLabel];
    [self createLoginButton];
    [self registerForSessionChangeNotification];
    [self checkAuthTokenAndUpdateLoginButtonUI];
}

- (void)checkAuthTokenAndUpdateLoginButtonUI
{
    // Check the session for a cached token to show the proper authenticated
    // UI. However, since this is not user intitiated, do not show the login UX.
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate openSessionWithAllowLoginUI:NO];
}

- (void)registerForSessionChangeNotification
{
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(sessionStateChanged:)
     name:FBSessionStateChangedNotification
     object:nil];
}

#warning Change Method Scope to Private
- (void)sessionStateChanged:(NSNotification*)notification {
    if (FBSession.activeSession.isOpen) {
        [self.authButton setTitle:@"Logout from Facebook" forState:UIControlStateNormal];
        [self loginSuccessful];
    } else {
        [self.authButton setTitle:@"Login with Facebook" forState:UIControlStateNormal];
    }
}

- (void)loginSuccessful
{
    // TODO: Replace with Feed ViewController
    [self getUserDataFromFacebook];
    
}

-(void) getUserDataFromFacebook
{
    // Log details about HTTP requests and response to the output pane in Xcode
    [FBSettings setLoggingBehavior:[NSSet setWithObjects:
                                    FBLoggingBehaviorFBRequests, nil]];
    
    // Request User Information
    [FBRequestConnection
     startForMeWithCompletionHandler:^(FBRequestConnection *connection,
                                       id<FBGraphUser> user,
                                       NSError *error) {
         if (!error) {
             self.me = (NSDictionary *) user;
             NSLog(@"Me: %@",self.me);
             
             NSString *userInfo = @"";
             
             // Example: typed access (name)
             // - no special permissions required
             userInfo = [userInfo
                         stringByAppendingString:
                         [NSString stringWithFormat:@"Name: %@",
                          user.name]];
             
             // Example: typed access, (birthday)
             // - requires user_birthday permission
             userInfo = [userInfo
                         stringByAppendingString:
                         [NSString stringWithFormat:@"Birthday: %@",
                          user.birthday]];
             
             // Example: partially typed access, to location field,
             // name key (location)
             // - requires user_location permission
             userInfo = [userInfo
                         stringByAppendingString:
                         [NSString stringWithFormat:@"Location: %@",
                          [user.location objectForKey:@"name"]]];
             
             // Example: access via key (locale)
             // - no special permissions required
             userInfo = [userInfo
                         stringByAppendingString:
                         [NSString stringWithFormat:@"Locale: %@",
                          [user objectForKey:@"locale"]]];
             
             // Example: access via key for array (languages)
             // - requires user_likes permission
             if ([user objectForKey:@"languages"]) {
                 NSArray *languages = [user objectForKey:@"languages"];
                 NSMutableArray *languageNames = [[NSMutableArray alloc] init];
                 for (int i = 0; i < [languages count]; i++) {
                     [languageNames addObject:[[languages
                                                objectAtIndex:i]
                                               objectForKey:@"name"]];
                 }
                 userInfo = [userInfo
                             stringByAppendingString:
                             [NSString stringWithFormat:@"Languages: %@",
                              languageNames]];
             }
             
             NSLog(@"UserInfo From Facebook: %@", userInfo);
             // TODO: Display user info in Profile Page
             // TODO: Push User info to Rails Backend Server
         }
     }];
    
}

- (void)authButtonAction:(id)sender
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    // If the user is authenticated, log out when the button is clicked.
    // If the user is not authenticated, log in when the button is clicked.
    if (FBSession.activeSession.isOpen) {
        [appDelegate closeSession];
        // TODO: Replace with Login ViewController
    } else {
        // The user has initiated a login, so call the openSession method
        // and show the login UX if necessary.
        [appDelegate openSessionWithAllowLoginUI:YES];
    }
}

- (void)createTitleLabel
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 120, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"Talk Local Dev";
    [self.view addSubview:titleLabel];
}

- (void)createLoginButton
{
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    loginButton.frame = CGRectMake(60, 200, 200, 44);
    [loginButton setTitle:@"Login with Facebook" forState:UIControlStateNormal];
    [self.view addSubview:loginButton];

    [loginButton addTarget:self
                    action:@selector(authButtonAction:)
          forControlEvents:UIControlEventTouchUpInside];

    self.authButton = loginButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    [self unregisterForSessionStateChangeNotification];
}

- (void)unregisterForSessionStateChangeNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
