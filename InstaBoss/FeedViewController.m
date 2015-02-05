//
//  FeedViewController.m
//  InstaBoss
//
//  Created by Aaron Bradley on 2/3/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//
#import <Parse/Parse.h>

#import "Constants.h"

#import "FeedViewController.h"
#import "CameraViewController.h"
#import "CommentsViewController.h"

#import "Photo.h"
#import "FeedCell.h"

@interface FeedViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tablePhotos;

@end

@implementation FeedViewController
{
    NSMutableArray *photos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [self loadFeed];
}

- (void)loadFeed {
    photos = [NSMutableArray new];

    PFQuery *query = [PFQuery queryWithClassName:kParsePhotoObjectClass];

    [query orderByDescending:@"createdAt"];
    dispatch_queue_t feedQueue = dispatch_queue_create("feedQueue",NULL);

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        dispatch_async(feedQueue, ^{
            for(PFObject *parseObject in objects) {
                [photos addObject:[[Photo alloc] initWithParse:parseObject]];
            }


            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tablePhotos reloadData];
            });
        });
    }];

}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([@"ViewCommentsSegue" isEqualToString:segue.identifier]) {
        CommentsViewController *controller = segue.destinationViewController;
        controller.photo = [photos objectAtIndex:self.tablePhotos.indexPathForSelectedRow.row];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return photos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FeedCell" forIndexPath:indexPath];

    Photo *photo = photos[indexPath.row];
    cell.textLabel.text = photo.caption;
    cell.imageView.image = photo.image;
    return cell;
}

//- (void) likeImage {
//    [object addUniqueObject:[PFUser currentUser].objectId forKey:@"favorites"];
//    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (!error) {
//            NSLog(@"liked picture!");
//            [self likedSuccess];
//        }
//        else {
//            [self likedFail];
//        }
//    }];
//}

@end
