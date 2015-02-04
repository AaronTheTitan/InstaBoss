//
//  FeedViewController.m
//  InstaBoss
//
//  Created by Aaron Bradley on 2/3/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//
#import <Parse/Parse.h>


#import "FeedViewController.h"

@interface FeedViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageTarget;

@end

@implementation FeedViewController
{
    NSMutableArray *parseObjects;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadPicture];
}

- (void)loadPicture {
    PFQuery *query = [PFQuery queryWithClassName:@"PhotoZ"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSLog(@"async call to Parse...");
        parseObjects = [NSMutableArray arrayWithArray:objects];

        NSLog(@"%li", parseObjects.count);
        PFFile *imageFile = [((PFObject *)parseObjects[0]) objectForKey:@"Image"];

        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!data) {
                return NSLog(@"%@", error);
            }

            NSLog(@"Downloading image from Parse...");
            // Do something with the image
            self.imageTarget.image = [UIImage imageWithData:data];

        }];

    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
