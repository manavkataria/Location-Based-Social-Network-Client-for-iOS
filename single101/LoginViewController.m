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
    } else {
        [self.authButton setTitle:@"Login with Facebook" forState:UIControlStateNormal];
    }
}

#warning returning void in place of IBAction as per FB Tutorial
- (void)authButtonAction:(id)sender
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    // If the user is authenticated, log out when the button is clicked.
    // If the user is not authenticated, log in when the button is clicked.
    if (FBSession.activeSession.isOpen) {
        [appDelegate closeSession];
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
