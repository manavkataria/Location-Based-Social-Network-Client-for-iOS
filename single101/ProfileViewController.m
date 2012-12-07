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
    
    //[self renderHardcodedProfile];
    //[self renderUserProfile];
}

- (void) renderUserProfile
{
    int x = 20;
    int y = 20;
    int xWidth = 280;
    int yHeight = 40;
    int yGap = 20;
    int bioHeight = yHeight;
    int scrollViewHeight;
    int scrollViewWidth = 320;
    float red = 1;
    float blue = 1;
    float green = 1;
    float alpha = 0.4f;
    
#if NAME_LABEL
    int imageXWidth = 100;
    int imageYHeight = 133;
#endif
    //self.view.backgroundColor = [UIColor whiteColor];
    
    // ScrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    
#if 0
    // Fetch Image Data
    NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:self.userProfile[@"image"]]];
    // TODO: Add placeholder image
    
    // Profile Image Button
    UIButton *profileThumbnail = [UIButton buttonWithType:UIButtonTypeCustom];
    [profileThumbnail setFrame:CGRectMake(x,y,imageXWidth,imageYHeight)];
    [profileThumbnail setImage:[UIImage imageWithData:mydata] forState:UIControlStateNormal];
    [profileThumbnail addTarget:self action:@selector(showZoomedPicture:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:profileThumbnail];
#else
    
    // Full Screen Image
    UIImageView *profilePicView = [[UIImageView alloc] init];
    [profilePicView setImageWithURL:[NSURL URLWithString:self.userProfile[@"image"]] placeholderImage:[UIImage imageNamed:@"placeholder_full.jpg"]];
    
    [profilePicView setContentMode:UIViewContentModeScaleAspectFit];
    profilePicView.frame = self.scrollView.frame;
    [self.scrollView addSubview:profilePicView];
#endif
    
    
    // Name
#if NAME_LABEL
    y = y + imageYHeight + yGap;
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(x,y,xWidth,yHeight)];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.text = self.userProfile[@"name"];
    [self.scrollView addSubview:nameLabel];
#else 
    self.title = self.userProfile[@"name"];
#endif
    
    // Location
    //y = y + yHeight + yGap;
    UILabel *cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(x,y,xWidth,yHeight)];
    cityLabel.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    
    if (![self.userProfile[@"location"] isKindOfClass:[NSNull class]]) {
        cityLabel.text = self.userProfile[@"location"];
    } else {
        NSLog(@"Null Location: %@",self.userProfile[@"location"]);
        cityLabel.text = @"";
    }
    
    [self.scrollView addSubview:cityLabel];
    
    // Age
    y = y + yHeight + yGap;
    UILabel *ageLabel = [[UILabel alloc] initWithFrame:CGRectMake(x,y,xWidth,yHeight)];
    ageLabel.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    ageLabel.text = self.userProfile[@"birthday"];
    [self.scrollView addSubview:ageLabel];
    
    // Bio
    y = y + yHeight + yGap;
    UITextView *biography = [[UITextView alloc] initWithFrame:CGRectMake(x,y,xWidth,bioHeight)];
    biography.font = [UIFont fontWithName:@"Helvetica" size:15];
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
  
#if 0
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
    ageLabel.layer.cornerRadius = 10;
    biography.layer.cornerRadius = 10;
    cityLabel.layer.cornerRadius = 10;
    
}

- (void) renderHardcodedProfile
{
    
    int x = 20;
    int y = 20;
    int xWidth = 280;
    int yHeight = 40;
    int yGap = 20;
    int bioHeight = yHeight;
    int imageXWidth = 100;
    int imageYHeight = 133;
    int scrollViewHeight;
    int scrollViewWidth = 320;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // ScrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    
    // Fetch Image Data
    NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://profile.ak.fbcdn.net/hprofile-ak-snc6/275717_100001091555213_134283289_s.jpg"]];
    // TODO: Add placeholder image
    
#ifdef PLAIN_IMAGE_NO_BUTTON
    // Profile Image (No Button)
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:mydata]];
    [imgView setContentMode:UIViewContentModeScaleAspectFill];
    imgView.frame = CGRectMake(x,y,imageXWidth,imageYHeight);
    [self.scrollView addSubview:imgView];
#else
    // Profile Image Button
    UIButton *profileThumbnail = [UIButton buttonWithType:UIButtonTypeCustom];
    [profileThumbnail setImage:[UIImage imageWithData:mydata] forState:UIControlStateNormal];
    //[profileThumbnail setImage:[UIImage imageWithData:mydata] forState:UIControlStateHighlighted];
    [profileThumbnail setFrame:CGRectMake(x,y,imageXWidth,imageYHeight)];
    [profileThumbnail addTarget:self action:@selector(showZoomedPicture:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:profileThumbnail];
#endif
    
    // Name
    y = y + imageYHeight + yGap;
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(x,y,xWidth,yHeight)];
    //nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2f];
    nameLabel.text = @"Name: Manav Kataria";
    [self.scrollView addSubview:nameLabel];
    
    // Location
    y = y + yHeight + yGap;
    UILabel *cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(x,y,xWidth,yHeight)];
    cityLabel.backgroundColor = [UIColor clearColor];
    cityLabel.text = @"From: India";
    [self.scrollView addSubview:cityLabel];
    
    // Age
    y = y + yHeight + yGap;
    UILabel *ageLabel = [[UILabel alloc] initWithFrame:CGRectMake(x,y,xWidth,yHeight)];
    ageLabel.backgroundColor = [UIColor clearColor];
    ageLabel.text = @"Age: Almost 29";
    [self.scrollView addSubview:ageLabel];
    
    // Bio
    y = y + yHeight + yGap;
    UITextView *biography = [[UITextView alloc] initWithFrame:CGRectMake(x,y,xWidth,bioHeight)];
    biography.font = [UIFont fontWithName:@"Helvetica" size:15];
    biography.editable = NO;
    biography.text = @"Hacker, Mentor, Startup Evangelist ...";
    [self.scrollView addSubview:biography];
    
    // Chat
    y = y + bioHeight + yGap;
    UIButton *chatButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    chatButton.frame = CGRectMake(x, y, xWidth, yHeight);
    [chatButton setTitle:@"Chat" forState:UIControlStateNormal];
    [self.scrollView addSubview:chatButton];
    [chatButton addTarget:self action:@selector(showChat:) forControlEvents:UIControlEventTouchUpInside];
    
    // Add Scroll View to self.view
    scrollViewHeight = y + yHeight + yGap;
    //NSLog(@"Scroll Height: %d", scrollViewHeight);
    self.scrollView.contentSize = CGSizeMake(scrollViewWidth,scrollViewHeight);
    [self.view addSubview:self.scrollView];
    
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
    // Needs nameLabel reference from view did load
    //nameLabel.layer.cornerRadius = 10;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#if Fetch_Json_From_Internet
#import "PhotoViewController.h"

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PhotoViewController *photoVC = [[PhotoViewController alloc] init];
    
    // Also finish these, setting the proper fileName and title
    
    photoVC.imageFileName = self.images[indexPath.row][@"filename"];
    photoVC.imageTitle = self.images[indexPath.row][@"title"];
    
    [self.navigationController pushViewController:photoVC animated:YES];
}
#endif

@end
