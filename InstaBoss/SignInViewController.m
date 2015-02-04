//
//  SignInViewController.m
//  InstaBoss
//
//  Created by Aaron Bradley on 2/4/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

#import "SignInViewController.h"

@interface SignInViewController ()
@property (strong, nonatomic) IBOutlet UITextField *textFieldUsername;
@property (strong, nonatomic) IBOutlet UITextField *textFieldPassword;

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];


}

- (IBAction)tapButtonLogin:(UIButton *)sender {
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        
    } else {
        // show the signup or login screen
    }
}

@end
