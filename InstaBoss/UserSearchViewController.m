//
//  UserSearchViewController.m
//  InstaBoss
//
//  Created by Fiaz Sami on 2/5/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

#import <Parse/Parse.h>
#import "Constants.h"

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

    NSMutableArray *following;
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

        PFQuery *socialProfile = [PFQuery queryWithClassName:kParseSocialObject];
        [socialProfile whereKey:@"username" equalTo:[PFUser currentUser].username];
        [socialProfile findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            following = objects.firstObject[@"Following"];

            [self.tableUsers reloadData];
        }];

        if (!error) {
            for(PFObject *object in objects) {
                User *user = [User new];
                user.userName = object[@"username"];
                if(![user.userName isEqualToString:[PFUser currentUser].username]) {
                    [users addObject:user];
                }
            }
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }


        filter = users;
        [self.tableUsers reloadData];
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

    if(searchBar.text.length == 0) {
        filter = users;
    }

    [self.tableUsers reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return filter.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FriendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCell" forIndexPath:indexPath];

    User *user = filter[indexPath.row];

    [cell isFollowing:[following containsObject:user.userName]];
    cell.friendTextLabel.text = user.userName;
    cell.delegate = self;

    return cell;
}



- (void)socializeWithUser:(FriendCell *)button {
    [User updateSocial:button.friendButton.titleLabel.text withUser:button.friendTextLabel.text];
}

@end
