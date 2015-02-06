//
//  EditProfileViewController.m
//  InstaBoss
//
//  Created by Aaron Bradley on 2/5/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

#import "EditProfileViewController.h"

@interface EditProfileViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    IBOutlet UITextField *textFieldDisplayName;
    IBOutlet UITextField *textFieldProfileDescription;
    IBOutlet UITextField *textFieldURL;

    IBOutlet UIButton *buttonEditProfile;
    IBOutlet UIButton *buttonTakePhoto;
    IBOutlet UIButton *buttonAddPhoto;

    IBOutlet UILabel *userDisplayName;
    IBOutlet UILabel *userProfileDescription;
    IBOutlet UILabel *userURL;

//    BOOL isEditing;

    IBOutlet UILabel *labelChangePassword;
    IBOutlet UITextField *textFieldChangeEmail;
    IBOutlet UITextField *textFieldCurrentPassword;
    IBOutlet UITextField *textFieldNewPassword;
    IBOutlet UITextField *textFieldConfirmNewPassword;


    IBOutlet UIImageView *imageViewProfile;

//    NSMutableArray *photos;
}
@end


@implementation EditProfileViewController

- (IBAction)tapButtonEditProfile:(UIButton *)sender {
    //    [self toggleEditing];
}

- (IBAction)tapButtonEditPhoto:(UIButton *)sender {
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
        textFieldDisplayName.text = userDisplayName.text;
        textFieldProfileDescription.text = userProfileDescription.text;
        textFieldURL.text = userURL.text;
}

//----------------------------------------------------------------

- (BOOL)isCameraEnabled {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self noCameraAlert];
        return NO;
    } else {
        return YES;
    }
}

- (void)noCameraAlert {
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Device has no camera" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [myAlertView show];
}

- (IBAction)tapButtonTakePhoto:(UIButton *)sender {
    if ([self isCameraEnabled]) {
        [self showSourcePicker:UIImagePickerControllerSourceTypeCamera];
    } else {
        [self noCameraAlert];
    }
}

- (IBAction)tapButtonSelectFromGallery:(UIButton *)sender {
    [self showSourcePicker:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];

    NSData *imageData = UIImageJPEGRepresentation(chosenImage, 1);
    PFFile *imageFile = [PFFile fileWithName:[NSString stringWithFormat:@"%@_profilePhoto.jpg", self.currentUser.username] data:imageData];

    self.currentUser[@"userPhoto"] = imageFile;
    [imageFile saveInBackground];

    imageViewProfile.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


- (void)showSourcePicker:(UIImagePickerControllerSourceType)source {

    UIImagePickerController *picker = [UIImagePickerController new];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = source;
    [self presentViewController:picker animated:YES completion:^{

    }];
}

//----------------------------------------------------------------

- (IBAction)tapButtonDismiss:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)tapButtonSaveEdits:(UIBarButtonItem *)sender {
    [self saveEdits];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveEdits {
    if (![textFieldNewPassword.text isEqualToString:@""]) {
        if (![textFieldNewPassword.text isEqualToString:textFieldConfirmNewPassword.text]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Whoa!" message:@"Passwords do not match" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }
     else {
//        buttonEditProfile.backgroundColor = [UIColor blueColor];
//        [buttonEditProfile setTitle:@"Edit Your Profile" forState:UIControlStateNormal];


        [self.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            self.currentUser.username = textFieldDisplayName.text;
            self.currentUser[@"userDescription"] = textFieldProfileDescription.text;
            self.currentUser[@"url"] = textFieldURL.text;
        }];

        userProfileDescription.text = self.currentUser[@"userDescription"];
        userURL.text = self.currentUser[@"url"];
    }

    if (![textFieldChangeEmail.text isEqualToString:@""]) {
        self.currentUser.email = textFieldChangeEmail.text;
        [self.currentUser saveInBackground];
    }
}

//- (void)toggleEditing {
//
//    if (isEditing == NO) {
//
//        isEditing = YES;
//
//        [self showEditFields];
//        buttonEditProfile.backgroundColor = [UIColor redColor];
//        [buttonEditProfile setTitle:@"! -- Done -- !" forState:UIControlStateNormal];
//
//    } else {
//
//        isEditing = NO;
//
//        [self hideEditFields];
//
//        if (![textFieldNewPassword.text isEqualToString:textFieldConfirmNewPassword.text]) {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Whoa!" message:@"Passwords do not match" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alert show];
//        } else {
//            buttonEditProfile.backgroundColor = [UIColor blueColor];
//            [buttonEditProfile setTitle:@"Edit Your Profile" forState:UIControlStateNormal];
//
//            currentUser.username = textFieldDisplayName.text;
//            currentUser[@"userDescription"] = textFieldProfileDescription.text;
//            currentUser[@"url"] = textFieldURL.text;
//            [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//                ///
//            }];
//            userProfileDescription.text = currentUser[@"userDescription"];
//            userURL.text = currentUser[@"url"];
//        }
//
//        if (![textFieldChangeEmail.text isEqualToString:@""]) {
//            currentUser.email = textFieldChangeEmail.text;
//            [currentUser saveInBackground];
//        }
//    }
//}
//
//- (void)hideEditFields {
//
//    textFieldDisplayName.enabled = NO;
//    textFieldDisplayName.alpha = 0;
//
//    textFieldProfileDescription.enabled = NO;
//    textFieldProfileDescription.alpha = 0;
//
//    textFieldURL.enabled = NO;
//    textFieldURL.alpha = 0;
//
//    userDisplayName.alpha = 1;
//    userProfileDescription.alpha = 1;
//    userURL.alpha = 1;
//
//    textFieldChangeEmail.enabled = NO;
//    textFieldCurrentPassword.enabled = NO;
//    textFieldNewPassword.enabled = NO;
//    textFieldConfirmNewPassword.enabled = NO;
//
//    textFieldChangeEmail.alpha = 0;
//    textFieldCurrentPassword.alpha = 0;
//    textFieldNewPassword.alpha = 0;
//    textFieldConfirmNewPassword.alpha = 0;
//    labelChangePassword.alpha = 0;
//
//    buttonTakePhoto.enabled = NO;
//    buttonTakePhoto.alpha = 0;
//
//    buttonAddPhoto.enabled = NO;
//    buttonAddPhoto.alpha = 0;
//}
//
//- (void)showEditFields {
//
//    textFieldDisplayName.enabled = YES;
//    textFieldDisplayName.alpha = 1;
//
//    textFieldProfileDescription.enabled = YES;
//    textFieldProfileDescription.alpha = 1;
//
//    textFieldURL.enabled = YES;
//    textFieldURL.alpha = 1;
//
//    textFieldDisplayName.text = userDisplayName.text;
//    textFieldProfileDescription.text = userProfileDescription.text;
//    textFieldURL.text = userURL.text;
//
//    userDisplayName.alpha = 0;
//    userProfileDescription.alpha = 0;
//    userURL.alpha = 0;
//
//    textFieldChangeEmail.enabled = YES;
//    textFieldCurrentPassword.enabled = YES;
//    textFieldNewPassword.enabled = YES;
//    textFieldConfirmNewPassword.enabled = YES;
//
//    textFieldChangeEmail.alpha = 1;
//    textFieldCurrentPassword.alpha = 1;
//    textFieldNewPassword.alpha = 1;
//    textFieldConfirmNewPassword.alpha = 1;
//    labelChangePassword.alpha = 1;
//
//    buttonTakePhoto.enabled = YES;
//    buttonTakePhoto.alpha = 1;
//
//    buttonAddPhoto.enabled = YES;
//    buttonAddPhoto.alpha = 1;
//}
@end
