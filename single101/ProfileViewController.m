//
//  ProfileViewController.m
//  single101
//
//  Created by Manav Kataria on 12/4/12.
//  Copyright (c) 2012 Manav Kataria. All rights reserved.
//

#import "ProfileViewController.h"

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
    
    int x = 20;
    int y = 20;
    int xWidth = 280;
    int yHeight = 40;
    int yGap = 20;
    int bioHeight = 172;
    int imageXWidth = 50;
    int imageYHeight = 50;
    int scrollViewHeight;
    int scrollViewWidth = 320;
    
    // ScrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    
    // Profile Image
    NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://graph.facebook.com/100004779815180/picture?type=square"]];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:mydata]];
    [imgView setContentMode:UIViewContentModeScaleAspectFill];
    imgView.frame = CGRectMake(x,y,imageXWidth,imageYHeight);
    [self.scrollView addSubview:imgView];
    
    // Name
    y = y + imageYHeight + yGap;
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(x,y,xWidth,yHeight)];
    nameLabel.text = @"Name: Manav Kataria";
    [self.scrollView addSubview:nameLabel];
    
    // Location
    y = y + yHeight + yGap;
    UILabel *cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(x,y,xWidth,yHeight)];
    cityLabel.text = @"From: India";
    [self.scrollView addSubview:cityLabel];
    
    // Age
    y = y + yHeight + yGap;
    UILabel *ageLabel = [[UILabel alloc] initWithFrame:CGRectMake(x,y,xWidth,yHeight)];
    ageLabel.text = @"Age: Almost 29";
    [self.scrollView addSubview:ageLabel];
    
    // Bio
    y = y + yHeight + yGap;
    UITextView *biography = [[UITextView alloc] initWithFrame:CGRectMake(x,y,xWidth,bioHeight)];
    biography.font = [UIFont fontWithName:@"Helvetica" size:15];
    biography.editable = NO;
    biography.text = @"Hacker, Mentor, Startup Evangelist ...";
    [self.scrollView addSubview:biography];
    
    scrollViewHeight = y + bioHeight + yGap;
    NSLog(@"Scroll Height: %d", scrollViewHeight);
    self.scrollView.contentSize = CGSizeMake(scrollViewWidth,scrollViewHeight);
    
    [self.view addSubview:self.scrollView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
