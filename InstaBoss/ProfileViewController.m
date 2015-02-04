//
//  SettingsViewController.m
//  InstaBoss
//
//  Created by Aaron Bradley on 2/4/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)tapButtonSignOut:(UIButton *)sender {
    [PFUser logOut];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
