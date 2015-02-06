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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    PFUser *user = [PFUser currentUser];
    if (user.username != nil) {
        [self performSegueWithIdentifier:@"login" sender:self];
    }
}

- (IBAction)tapButtonLogin:(UIButton *)sender {
    [PFUser logInWithUsernameInBackground:textFieldUsername.text password:textFieldPassword.text block:^(PFUser *user, NSError *error) {

        if (!error) {
            textFieldPassword.text = nil;
            textFieldUsername.text = nil;
            [self performSegueWithIdentifier:@"login" sender:self];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ooops!" message:@"Invalid login credentials" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }];
}

@end
