//
//  CommentsViewController.m
//  InstaBoss
//
//  Created by Fiaz Sami on 2/4/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

#import "CommentsViewController.h"

@interface CommentsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imagePhoto;

@end

@implementation CommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imagePhoto.image = self.photo.image;
}

- (IBAction)tapReturnToFeed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
