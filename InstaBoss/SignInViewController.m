//
//  SignInViewController.m
//  InstaBoss
//
//  Created by Aaron Bradley on 2/4/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

#import "SignInViewController.h"

@interface SignInViewController ()
{
    IBOutlet UITextField *textFieldUsername;
    IBOutlet UITextField *textFieldPassword;
}
@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];


}

- (IBAction)tapButtonLogin:(UIButton *)sender {
    [PFUser logInWithUsernameInBackground:textFieldUsername.text password:textFieldPassword.text block:^(PFUser *user, NSError *error) {
//        if (!error) {
//            NSLog(@"Login user!");
//            textFieldPassword.text = nil;
//            textFieldUsername.text = nil;
//            [self performSegueWithIdentifier:@"login" sender:self];
//        }
        if (error || [textFieldUsername.text isEqualToString:@""] || [textFieldPassword.text isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ooops!" message:@"Sorry we had a problem logging you in" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            textFieldPassword.text = nil;
            textFieldUsername.text = nil;
        } else {
            [self performSegueWithIdentifier:@"login" sender:self];

        }
    }];



    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {

    } else {
        // show the signup or login screen
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Make sure you entered your login information correctly :(" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}

- (IBAction)tapButtonCancel:(UIButton *)sender {
}

@end
