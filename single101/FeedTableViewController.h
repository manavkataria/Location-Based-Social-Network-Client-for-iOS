//
//  FeedTableViewController.h
//  single101
//
//  Created by Manav Kataria on 12/6/12.
//  Copyright (c) 2012 Manav Kataria. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface FeedTableViewController : UITableViewController  <CLLocationManagerDelegate>

@property (strong, nonatomic) UILabel *latitude;
@property (strong, nonatomic) UILabel *longitude;
@property (strong, nonatomic) UILabel *altitude;
@property (strong, nonatomic) UILabel *horizontalAccuracy;
@property (strong, nonatomic) UILabel *verticalAccuracy;
@property (strong, nonatomic) UILabel *distance;

@property (strong, nonatomic) CLLocation *myLocation;
@property (strong, nonatomic) CLLocation *startLocation;
@property (strong, nonatomic) CLLocationManager *locationManager;

-(CLLocationDistance)myDistanceFromLatitude:(CLLocationDegrees) latitude
                                  longitude:(CLLocationDegrees) longitude;

//- (IBAction)resetDistance:(id)sender;

@property (strong, nonatomic) NSArray *users;

@end
