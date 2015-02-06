//
//  UserSearchViewController.m
//  InstaBoss
//
//  Created by Fiaz Sami on 2/5/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

#import <Parse/Parse.h>

#import "UserSearchViewController.h"
#import "MapViewController.h"
#import "User.h"

#import "FriendCell.h"

@interface UserSearchViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, FriendCellDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchUsers;
@property (weak, nonatomic) IBOutlet UITableView *tableUsers;


@end

@implementation UserSearchViewController
{
    NSMutableArray *users;
    NSMutableArray *filter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadUsers];
}

- (void)loadUsers {
    users = [NSMutableArray new];

    PFQuery *query = [PFUser query];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for(PFObject *object in objects) {
                User *user = [User new];
                user.userName = object[@"username"];
                [users addObject:user];
            }
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MapViewController *map = segue.destinationViewController;
    map.user = filter[self.tableUsers.indexPathForSelectedRow.row];
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    filter = [NSMutableArray new];

    for(User *user in users) {
        if([user isMatch:searchText]) {
            [filter addObject:user];
        }
    }

    [self.tableUsers reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return filter.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FriendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCell" forIndexPath:indexPath];

    User *user = filter[indexPath.row];

    cell.friendTextLabel.text = user.userName;
    cell.delegate = self;

    return cell;
}



- (void)socializeWithUser:(FriendCell *)button {
    NSLog(@"clicked");
    NSLog(@"%@", button.friendTextLabel.text);
}

@end
