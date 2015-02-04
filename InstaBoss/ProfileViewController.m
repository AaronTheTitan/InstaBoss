//
//  SettingsViewController.m
//  InstaBoss
//
//  Created by Aaron Bradley on 2/4/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()
{
    IBOutlet UITextField *textFieldDisplayName;
    IBOutlet UITextField *textFieldProfileDescription;
    IBOutlet UITextField *textFieldURL;
    IBOutlet UIButton *buttonEditProfile;
    BOOL isEditing;

    IBOutlet UILabel *userDisplayName;
    IBOutlet UILabel *userProfileDescription;
    IBOutlet UILabel *userURL;
}

@property (strong, nonatomic) IBOutlet UIImageView *imageViewProfile;
@property (strong, nonatomic) IBOutlet UILabel *numberFollowing;
@property (strong, nonatomic) IBOutlet UILabel *numberOfFollowers;
@property (strong, nonatomic) IBOutlet UILabel *numberOfPosts;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"UserName Here";
}

- (void)viewDidAppear:(BOOL)animated {
    [self hideEditFields];

}

- (void)hideEditFields {

    textFieldDisplayName.enabled = NO;
    textFieldDisplayName.alpha = 0;

    textFieldProfileDescription.enabled = NO;
    textFieldProfileDescription.alpha = 0;

    textFieldURL.enabled = NO;
    textFieldURL.alpha = 0;

    userDisplayName.alpha = 1;
    userProfileDescription.alpha = 1;
    userURL.alpha = 1;
}

- (void)showEditFields {

    textFieldDisplayName.enabled = YES;
    textFieldDisplayName.alpha = 1;

    textFieldProfileDescription.enabled = YES;
    textFieldProfileDescription.alpha = 1;

    textFieldURL.enabled = YES;
    textFieldURL.alpha = 1;

    textFieldDisplayName.text = userDisplayName.text;
    textFieldProfileDescription.text = userDisplayName.text;
    textFieldURL.text = userURL.text;

    userDisplayName.alpha = 0;
    userProfileDescription.alpha = 0;
    userURL.alpha = 0;
}

- (IBAction)tapButtonEditProfile:(UIButton *)sender {
    [self toggleEditing];
}

- (void)toggleEditing {

    if (isEditing == NO) {

        isEditing = YES;

        [self showEditFields];
        [buttonEditProfile setTitle:@"Done" forState:UIControlStateNormal];

    } else {

        isEditing = NO;

        [self hideEditFields];
        [buttonEditProfile setTitle:@"Edit Your Profile" forState:UIControlStateNormal];
    }
}

- (IBAction)tapButtonSignOut:(UIBarButtonItem *)sender {
    [PFUser logOut];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
