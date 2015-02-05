//
//  SearchViewController.m
//  InstaBoss
//
//  Created by Aaron Bradley on 2/5/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

#import <Parse/Parse.h>
#import "Constants.h"
#import "SearchViewController.h"


@interface SearchViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
{
    IBOutlet UITableView *tableViewSearch;
    IBOutlet UISearchBar *searchBarInput;
}

@end

@implementation SearchViewController
{
    NSArray *searchResults;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    searchResults = [NSArray new];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchCell" forIndexPath:indexPath];

    return cell;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    PFQuery *query = [PFQuery queryWithClassName:kParseHashTagObjectClass];
    
}


@end
