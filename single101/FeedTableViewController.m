//
//  FeedTableViewController.m
//  single101
//
//  Created by Manav Kataria on 12/6/12.
//  Copyright (c) 2012 Manav Kataria. All rights reserved.
//

#import "FeedTableViewController.h"
#import "AFJSONRequestOperation.h"
#import "UIImageView+AFNetworking.h"
#import "ProfileViewController.h"

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
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSLog(@"UserProfile: %@",self.users[indexPath.row]);
    cell.textLabel.text = self.users[indexPath.row][@"name"];
    
    if (![self.users[indexPath.row][@"location"] isKindOfClass:[NSNull class]]) {
        cell.detailTextLabel.text = self.users[indexPath.row][@"location"];
    } else {
        NSLog(@"Null Location: %@",self.users[indexPath.row][@"location"]);
        cell.detailTextLabel.text = @"";
    }
    
    [cell.imageView setImageWithURL:[NSURL URLWithString:self.users[indexPath.row][@"image"]] placeholderImage:[UIImage imageNamed:@"placeholder_t.gif"]];
    
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
    
    profileViewController.userProfile = self.users[indexPath.row];
    [profileViewController renderUserProfile];

    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:profileViewController animated:YES];
    
}

- (void)fetchUsers
{
    NSURL *url = [[NSURL alloc] initWithString:@"http://talklocaldev.herokuapp.com/users.json"];
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


@end
