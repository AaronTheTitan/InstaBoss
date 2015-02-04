//
//  SignUpViewController.m
//  InstaBoss
//
//  Created by Aaron Bradley on 2/3/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()
{
    IBOutlet UITextField *textFieldUsername;
    IBOutlet UITextField *textFieldPassword;
    IBOutlet UITextField *textFieldPasswordConfirm;
    IBOutlet UITextField *textFieldEmailAddress;
}
@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    PFUser *user = [PFUser currentUser];
    if (user.username != nil) {

    } else {

    }

}

- (IBAction)tapButtonSignUp:(UIButton *)sender {
    [self checkFieldsForCompletion];
}

- (void)checkFieldsForCompletion {

    if ([textFieldUsername.text isEqualToString:@""] || [textFieldEmailAddress.text isEqualToString:@""] || [textFieldPassword.text isEqualToString:@""] || [textFieldPasswordConfirm.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Aw Schnaps!" message:@"Make sure you complete all fields and try again :(" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    } else {
        [self checkFieldsForMatch];
    }
}

- (void)checkFieldsForMatch {

    if (![textFieldPassword.text isEqualToString:textFieldPasswordConfirm.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Aw Schnaps!" message:@"Passwords don't match!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    } else {
        [self registerNewUser];
    }
}

- (void)registerNewUser {

    PFUser *newUser = [PFUser new];
    newUser.username = textFieldUsername.text;
    newUser.password = textFieldPassword.text;
    newUser.email = textFieldEmailAddress.text;

    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSLog(@"Registration success!");
            [self performSegueWithIdentifier:@"newUserLogin" sender:self];
        }
        else {
            NSLog(@"There was an error in registration");
            UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Something went wrong, try again :(" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [myAlertView show];
        }
    }];
}




@end
