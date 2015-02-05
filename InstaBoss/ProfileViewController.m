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

    IBOutlet UILabel *userDisplayName;
    IBOutlet UILabel *userProfileDescription;
    IBOutlet UILabel *userURL;

    BOOL isEditing;

    IBOutlet UILabel *labelChangePassword;
    IBOutlet UITextField *textFieldChangeEmail;
    IBOutlet UITextField *textFieldCurrentPassword;
    IBOutlet UITextField *textFieldNewPassword;
    IBOutlet UITextField *textFieldConfirmNewPassword;
}

//@property PFUser *user;

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
    PFUser *user = [PFUser currentUser];

    userDisplayName.text = user.username;
    userProfileDescription.text = user[@"userDescription"];

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

    textFieldChangeEmail.enabled = NO;
    textFieldCurrentPassword.enabled = NO;
    textFieldNewPassword.enabled = NO;
    textFieldConfirmNewPassword.enabled = NO;

    textFieldChangeEmail.alpha = 0;
    textFieldCurrentPassword.alpha = 0;
    textFieldNewPassword.alpha = 0;
    textFieldConfirmNewPassword.alpha = 0;
    labelChangePassword.alpha = 0;
    
}

- (void)showEditFields {

    textFieldDisplayName.enabled = YES;
    textFieldDisplayName.alpha = 1;

    textFieldProfileDescription.enabled = YES;
    textFieldProfileDescription.alpha = 1;

    textFieldURL.enabled = YES;
    textFieldURL.alpha = 1;

    textFieldDisplayName.text = userDisplayName.text;
    textFieldProfileDescription.text = userProfileDescription.text;
    textFieldURL.text = userURL.text;

    userDisplayName.alpha = 0;
    userProfileDescription.alpha = 0;
    userURL.alpha = 0;

    textFieldChangeEmail.enabled = YES;
    textFieldCurrentPassword.enabled = YES;
    textFieldNewPassword.enabled = YES;
    textFieldConfirmNewPassword.enabled = YES;

    textFieldChangeEmail.alpha = 1;
    textFieldCurrentPassword.alpha = 1;
    textFieldNewPassword.alpha = 1;
    textFieldConfirmNewPassword.alpha = 1;
    labelChangePassword.alpha = 1;
}

- (IBAction)tapButtonEditProfile:(UIButton *)sender {
    [self toggleEditing];
}

- (void)toggleEditing {

    if (isEditing == NO) {

        isEditing = YES;

        [self showEditFields];
        buttonEditProfile.backgroundColor = [UIColor redColor];
        [buttonEditProfile setTitle:@"! -- Done -- !" forState:UIControlStateNormal];

    } else {

        isEditing = NO;

        [self hideEditFields];
        buttonEditProfile.backgroundColor = [UIColor blueColor];
        [buttonEditProfile setTitle:@"Edit Your Profile" forState:UIControlStateNormal];

        PFUser *user = [PFUser currentUser];
        user.username = textFieldDisplayName.text;
        user[@"userDescription"] = textFieldProfileDescription.text;
        [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            NSLog(@"it's logging");
        }];


//        user.userDescription = textFieldProfileDescription.text;
//        user.user = textFieldProfileDescription.text;

        userProfileDescription.text = user[@"userDescription"];
        userURL.text = textFieldURL.text;

    }
}

- (IBAction)tapButtonSignOut:(UIBarButtonItem *)sender {
    [PFUser logOut];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
