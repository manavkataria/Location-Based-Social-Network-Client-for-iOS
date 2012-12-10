//
//  ProfileViewController.m
//  single101
//
//  Created by Manav Kataria on 12/4/12.
//  Copyright (c) 2012 Manav Kataria. All rights reserved.
//

#import "ProfileViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+AFNetworking.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Profile";
        self.tabBarItem.image = [UIImage imageNamed:@"tab_icon_profile"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
}

- (NSInteger) birthdayStringToAge:(NSString *)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    NSDate *dateFromString = [[NSDate alloc] init];
    dateFromString = [dateFormatter dateFromString:dateString];
    
    NSDate* birthday = dateFromString;
    NSDate* now = [NSDate date];
    NSDateComponents* ageComponents = [[NSCalendar currentCalendar]
                                       components:NSYearCalendarUnit
                                       fromDate:birthday
                                       toDate:now
                                       options:0];

    NSInteger age = [ageComponents year];
    
    return age;
}

- (void) renderUserProfile
{
    int x = 20;
    int y = 280;
    int xWidth = 220;
    int yHeight = 70;
    int yGap = 20;
    int scrollViewHeight;
    int scrollViewWidth = 320;
    float red = 1;
    float blue = 1;
    float green = 1;
    float alpha = 0.4f;

#if BIO
    int bioHeight = yHeight;
#endif
    
    // Name
    self.title = self.userProfile[@"name"];
    
    // ScrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    
    // Full Profile Image
    UIImageView *profilePicView = [[UIImageView alloc] init];
    
    if (![self.userProfile[@"ProfilePicFullURL"] isKindOfClass:[NSNull class]]) {
        [profilePicView setImageWithURL:[NSURL URLWithString:self.userProfile[@"ProfilePicFullURL"] ] placeholderImage:[UIImage imageNamed:@"placeholder_full.jpg"]];
    } else {
        [profilePicView setImageWithURL:[NSURL URLWithString:self.userProfile[@"image"] ] placeholderImage:[UIImage imageNamed:@"placeholder_full.jpg"]];
    }
    
    
    [profilePicView setContentMode:UIViewContentModeScaleAspectFit];
    profilePicView.frame = self.scrollView.frame;
    [self.scrollView addSubview:profilePicView];
    
    // City + Age + Distance
    UILabel *description = [[UILabel alloc] initWithFrame:CGRectMake(x,y,xWidth,yHeight)];
    description.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    description.numberOfLines = 0;
    
    if (![self.userProfile[@"location"] isKindOfClass:[NSNull class]]) {
        NSString *descText = [NSString stringWithFormat:@" %@\n %d years\n %d meters away",
                                 self.userProfile[@"location"],
                                 [self birthdayStringToAge:self.userProfile[@"birthday"]],
                                 (int) self.userDistance];
        description.text = descText;
        NSLog(@"cityAgeText: %@",descText);
    } else {
        NSLog(@"Null Location: %@",self.userProfile[@"location"]);
        NSString *descText = [NSString stringWithFormat:@" %d years\n %d meters away",
                                 [self birthdayStringToAge:self.userProfile[@"birthday"]],
                                 (int) self.userDistance];
        description.text = descText;
    }
    
    [self.scrollView addSubview:description];

#if BIO
    // Bio
    y = y + yHeight + yGap;
    UITextView *biography = [[UITextView alloc] initWithFrame:CGRectMake(x,y,xWidth,bioHeight)];
    //biography.font = [UIFont fontWithName:@"Helvetica" size:15];
    biography.editable = NO;
    biography.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    
    //FIXME: Crashes when bio is "<null>";
    if (![self.userProfile[@"bio"] isKindOfClass:[NSNull class]]) {
        biography.text = self.userProfile[@"bio"];
    } else {
        NSLog(@"Null Location: %@",self.userProfile[@"bio"]);
        biography.text = @"Not Available";
    }
    [self.scrollView addSubview:biography];
#endif 

#if CHAT_BUTTON_REGULAR
    // Chat
    y = y + bioHeight + yGap;
    UIButton *chatButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    chatButton.frame = CGRectMake(x, y, xWidth, yHeight);
    [chatButton setTitle:@"Fav/Chat" forState:UIControlStateNormal];
    [self.scrollView addSubview:chatButton];
    [chatButton addTarget:self action:@selector(showChat:) forControlEvents:UIControlEventTouchUpInside];
#else
    UIBarButtonItem *chatButton = [[UIBarButtonItem alloc] initWithTitle:@"Chat"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(showChat:)];
    self.navigationItem.rightBarButtonItem = chatButton;
#endif
    
    // Add Scroll View to self.view
    scrollViewHeight = y + yHeight + yGap;
    //NSLog(@"Scroll Height: %d", scrollViewHeight);
    self.scrollView.contentSize = CGSizeMake(scrollViewWidth,scrollViewHeight);
    [self.view addSubview:self.scrollView];
    
    self.view.layer.cornerRadius = 10;
    self.scrollView.layer.cornerRadius = 10;
    description.layer.cornerRadius = 10;

#if BIO
    biography.layer.cornerRadius = 10;
#endif 
}

- (void)showZoomedPicture:(UIButton *)sender
{
    UIViewController *profilePicZoomed = [[UIViewController alloc] init];
    profilePicZoomed.view.frame = self.view.frame;
    profilePicZoomed.title = self.userProfile[@"name"];
    
    UIImageView *profilePicView = [[UIImageView alloc] init];
    [profilePicView setImageWithURL:[NSURL URLWithString:self.userProfile[@"image"]] placeholderImage:[UIImage imageNamed:@"placeholder_full.jpg"]];
    
    [profilePicView setContentMode:UIViewContentModeScaleAspectFit];
    profilePicView.frame = profilePicZoomed.view.frame;
    [profilePicZoomed.view addSubview:profilePicView];
    
    [self.navigationController pushViewController:profilePicZoomed animated:YES];
}

- (void)showLocation
{
    //LocationViewController *locationViewController = [[LocationViewController alloc] init];
    
    // Pass the selected object to the new view controller.
    //[self.navigationController pushViewController:locationViewController animated:YES];
}

- (void)showChat:(UIButton *)sender
{
    NSLog(@"showChat");
    // TODO: Create Chat View Controller.
    // ChatViewController *favVC = [[ChatViewController alloc] init];
    // [self.navigationController pushViewController:favVC animated:YES];
}

// Rounded Rectangle - Impacts Performance!
- (void)enableRoundedRects
{
    self.view.layer.cornerRadius = 10;
    self.scrollView.layer.cornerRadius = 10;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
