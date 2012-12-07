//
//  ProfileViewController.m
//  single101
//
//  Created by Manav Kataria on 12/4/12.
//  Copyright (c) 2012 Manav Kataria. All rights reserved.
//

#import "ProfileViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "FavoritesViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title =@"Profile";
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
    int imageXWidth = 100;
    int imageYHeight = 133;
    int scrollViewHeight;
    int scrollViewWidth = 320;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // ScrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    
    // Fetch Image Data
    NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:self.userProfile[@"image"]]];
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
    nameLabel.text = self.userProfile[@"name"];
    [self.scrollView addSubview:nameLabel];
    
    // Location
    y = y + yHeight + yGap;
    UILabel *cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(x,y,xWidth,yHeight)];
    cityLabel.backgroundColor = [UIColor clearColor];
    cityLabel.text = self.userProfile[@"location"];
    [self.scrollView addSubview:cityLabel];
    
    // Age
    y = y + yHeight + yGap;
    UILabel *ageLabel = [[UILabel alloc] initWithFrame:CGRectMake(x,y,xWidth,yHeight)];
    ageLabel.backgroundColor = [UIColor clearColor];
    ageLabel.text = self.userProfile[@"birthday"];
    [self.scrollView addSubview:ageLabel];
    
    // Bio
    y = y + yHeight + yGap;
    UITextView *biography = [[UITextView alloc] initWithFrame:CGRectMake(x,y,xWidth,bioHeight)];
    biography.font = [UIFont fontWithName:@"Helvetica" size:15];
    biography.editable = NO;
    //FIXME: Crashes when bio is "<null>";
    //biography.text = self.userProfile[@"bio"];
    biography.text = @"Not Available";
    [self.scrollView addSubview:biography];
    
    // Chat
    y = y + bioHeight + yGap;
    UIButton *chatButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    chatButton.frame = CGRectMake(x, y, xWidth, yHeight);
    [chatButton setTitle:@"Fav/Chat" forState:UIControlStateNormal];
    [self.scrollView addSubview:chatButton];
    [chatButton addTarget:self action:@selector(showChat:) forControlEvents:UIControlEventTouchUpInside];
    
    // Add Scroll View to self.view
    scrollViewHeight = y + yHeight + yGap;
    //NSLog(@"Scroll Height: %d", scrollViewHeight);
    self.scrollView.contentSize = CGSizeMake(scrollViewWidth,scrollViewHeight);
    [self.view addSubview:self.scrollView];
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
    profilePicZoomed.title = @"Profile Pic";
    //FIXME: Fetch Name of Person as Title ^
    
    NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://profile.ak.fbcdn.net/hprofile-ak-snc6/275717_100001091555213_134283289_n.jpg"]];
    UIImageView *profilePicView = [[UIImageView alloc]
                               initWithImage:[UIImage imageWithData:mydata]];
    [profilePicView setContentMode:UIViewContentModeScaleAspectFit];
    profilePicView.frame = profilePicZoomed.view.frame;
    [profilePicZoomed.view addSubview:profilePicView];
    
    [self.navigationController pushViewController:profilePicZoomed animated:YES];
}

- (void)showChat:(UIButton *)sender
{
    NSLog(@"showChat");
    // TODO: Change to Chat View Controller.
    FavoritesViewController *favVC = [[FavoritesViewController alloc] init];
    [self.navigationController pushViewController:favVC animated:YES];
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
