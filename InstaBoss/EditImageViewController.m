//
//  EditImageViewController.m
//  InstaBoss
//
//  Created by Aaron Bradley on 2/3/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

#import "EditImageViewController.h"

@interface EditImageViewController ()



@end

@implementation EditImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    PFObject *anotherObjectTest = [PFObject objectWithClassName:@"Photo"];
    [anotherObjectTest setValue:@"anotherPicture" forKey:@"image"];
    [anotherObjectTest saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"it worked");
        } else {
            UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Something went wrong, try again :-(" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [myAlertView show];
        }
    }];
}

- (void)tapButtonSaveImage {
    
}

@end
