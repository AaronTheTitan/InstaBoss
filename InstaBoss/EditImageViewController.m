//
//  EditImageViewController.m
//  InstaBoss
//
//  Created by Aaron Bradley on 2/3/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

#import "EditImageViewController.h"

@interface EditImageViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textFieldCaption;

@end

@implementation EditImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)tapButtonSave:(UIButton *)sender {
    PFObject *photo = [PFObject objectWithClassName:@"Photo"];
    NSData *imageData = UIImagePNGRepresentation(self.imageTarget.image);
    PFFile *imageFile = [PFFile fileWithName:self.textFieldCaption.text data:imageData];

    [photo setObject:self.textFieldCaption.text forKey:@"Caption"];
    [photo setObject:imageFile forKey:@"Image"];

    [photo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(succeeded) {
            NSLog(@"SAVE SUCCEEDED == %i", succeeded);
        } else if(error) {
            UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Something went wrong, try again :(" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [myAlertView show];
        }
    }];
}

- (IBAction)tapButtonCancel:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
