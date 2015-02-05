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
#import "HashTag.h"

@interface SearchViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
{
    IBOutlet UITableView *tableViewSearch;
    IBOutlet UISearchBar *searchBarInput;
}



@end

@implementation SearchViewController
{
    NSArray *searchResults;
    NSMutableArray *filter;
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self cacheSearch];
}

- (void)cacheSearch {
    PFQuery *query = [PFQuery queryWithClassName:kParseHashTagObjectClass];

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error) {
            NSLog(@"ERROR IN SEARCH CONTROLLER");
        } else {
            NSMutableArray *results = [NSMutableArray new];
            for(PFObject *object in objects) {
                HashTag *hashTag = [[HashTag alloc] initWithParse:object];
                [results addObject:hashTag];
            }
            searchResults = [NSArray arrayWithArray:results];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return filter.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchCell" forIndexPath:indexPath];

    HashTag *hashTag = filter[indexPath.row];
    cell.textLabel.text = hashTag.tag;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%li tagged items", hashTag.items.count];

    return cell;
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    filter = [NSMutableArray new];

    for(HashTag *hashTag in searchResults) {
            if([hashTag isMatch:searchText]) {
                [filter addObject:hashTag];
            }
        }

    [tableViewSearch reloadData];
}



@end
