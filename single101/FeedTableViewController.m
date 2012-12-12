//
//  FeedTableViewController.m
//  single101
//
//  Created by Manav Kataria on 12/6/12.
//  Copyright (c) 2012 Manav Kataria. All rights reserved.
//

#import "FeedTableViewController.h"
#import "AFJSONRequestOperation.h"
#import "AFHTTPClient.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "ProfileViewController.h"

#define BASE_URL    "http://talklocaldev.herokuapp.com/"

@interface FeedTableViewController ()

@end

@implementation FeedTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title = @"Feed";
        self.tabBarItem.image = [UIImage imageNamed:@"tab_icon_group"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set Location Manager
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.delegate = self;
    [_locationManager startUpdatingLocation];
    _startLocation = nil;
    
    [self fetchUsers];
    
     // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Cell Style
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Name
    NSLog(@"UserProfile: %@",self.users[indexPath.row]);
    cell.textLabel.text = self.users[indexPath.row][@"name"];
    
    // Image
    [cell.imageView setImageWithURL:[NSURL URLWithString:self.users[indexPath.row][@"image"]] placeholderImage:[UIImage imageNamed:@"placeholder_t.gif"]];
    
    // Location
    if (![self.users[indexPath.row][@"location"] isKindOfClass:[NSNull class]]) {
        cell.detailTextLabel.text = self.users[indexPath.row][@"location"];
    } else {
        NSLog(@"Null Location: %@",self.users[indexPath.row][@"location"]);
        cell.detailTextLabel.text = @"";
    }

    // Distance from User
    if ([self.users[indexPath.row][@"location"] isKindOfClass:[NSNull class]] ||
        [self.users[indexPath.row][@"latitude"] isKindOfClass:[NSNull class]] ||
        [self.users[indexPath.row][@"longitude"] isKindOfClass:[NSNull class]]) {
        NSLog(@"Null Location/lat/long for user: %@", self.users[indexPath.row][@"name"]);
    } else {
        CLLocationDistance distance = [self myDistanceFromUserIndexPath:indexPath];
        NSString *distanceStr = [NSString stringWithFormat:@"(%d km away) %@",
                                 (int) (distance/1000), self.users[indexPath.row][@"location"]];
        cell.detailTextLabel.text = distanceStr;
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    ProfileViewController *profileViewController = [[ProfileViewController alloc] init];
    
    // Set Profile
    profileViewController.userProfile = self.users[indexPath.row];
    profileViewController.userDistance = [self myDistanceFromUserIndexPath:indexPath];
    [profileViewController renderUserProfile];

    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:profileViewController animated:YES];
    
}

- (void)fetchUsers
{
    NSURL *url = [[NSURL alloc] initWithString:@BASE_URL"users.json"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        //NSLog(@"Fetched Feed JSON: %@",JSON);
        self.users = JSON;
        [self.tableView reloadData]; // this is necessary, because by the time this runs, tableView:numberOfRowsInSection has already executed
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"NSError: %@",[error localizedDescription]);
    }];
    
    [operation start];
}

/********************************************* LOCATION CONTROL *********************************************/
/********************************************* LOCATION CONTROL *********************************************/
/********************************************* LOCATION CONTROL *********************************************/

-(void)resetDistance:(id)sender
{
    _startLocation = nil;
}

#pragma mark -
#pragma mark CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager
   didUpdateToLocation:(CLLocation *)newLocation
          fromLocation:(CLLocation *)oldLocation
{
    // NSLog(@"Location: %@", [newLocation description]);
    
    // Set Property
    _myLocation = newLocation;

    // Refresh Table
    [self.tableView reloadData];

    // Upload Location
    [self uploadLocationCoordinates];

    NSString *accuracyString = [[NSString alloc]
                                           initWithFormat:@"%+.3f",
                                           newLocation.horizontalAccuracy];
    //_horizontalAccuracy.text = currentHorizontalAccuracy;
    
    NSLog(@"Accuracy in Meters: %@",accuracyString);
}

-(CLLocationDistance)myDistanceFromUserIndexPath:(NSIndexPath *)indexPath
{
    if ([self.users[indexPath.row][@"latitude"] isKindOfClass:[NSNull class]] ||
        [self.users[indexPath.row][@"latitude"] isKindOfClass:[NSNull class]]) {
        NSLog(@"Warning: Latitude and Longitude Not Available for user: %@ ",self.users[indexPath.row][@"users"]);
        return -1;
    }
         
    CLLocationDegrees latitude = [self.users[indexPath.row][@"latitude"] doubleValue];
    CLLocationDegrees longitude = [self.users[indexPath.row][@"longitude"] doubleValue];
    
    CLLocationDistance distance = [self myDistanceFromLatitude:latitude
                                                     longitude:longitude];

    return distance;
}

-(CLLocationDistance)myDistanceFromLatitude:(CLLocationDegrees) latitude
                                  longitude:(CLLocationDegrees) longitude
{
    CLLocation *otherLocation = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    CLLocation *austinLocation = [[CLLocation alloc] initWithLatitude:30.2306 longitude:-97.834];
    
    if (self.myLocation == NULL) {
        NSLog(@"myLocation is: NULL");
    } else {
        NSLog(@"myLocation is: %@", [self.myLocation description]);
    }
    
    if (self.myLocation == NULL) {
        NSLog(@"Distance from Austin (default): %f", [austinLocation distanceFromLocation:otherLocation]);
        return [austinLocation distanceFromLocation:otherLocation];
    } else {
        NSLog(@"Distance from myLocation: %f", [self.myLocation distanceFromLocation:otherLocation]);
        return [self.myLocation distanceFromLocation:otherLocation];
    }
    
}

-(void)locationManager:(CLLocationManager *)manager
      didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", [error  description]);
    NSLog(@"Are Location Services enabled on device?");
    //NSLog(@"Error All: %@", error);
}

-(void)uploadLocationCoordinates
{
    NSURL *url = [NSURL URLWithString:@BASE_URL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    
    CLLocationDegrees latitude = self.myLocation.coordinate.latitude;
    CLLocationDegrees longitude = self.myLocation.coordinate.longitude;
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSNumber numberWithDouble:latitude], @"latitude",
                            [NSNumber numberWithDouble:longitude], @"longitude",
                            nil];
    
#warning "Uploading Location Coordinates for User#5 (Manav Kataria) ONLY!"
    [httpClient putPath:@"users/5"
             parameters:params
                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    NSString *text = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                    NSLog(@"PUT Response: %@", text);
                    NSLog(@"Uploading Location Coordinates Successful!");
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"PUT %@", [error localizedDescription]);
                }
     ];
}

@end
