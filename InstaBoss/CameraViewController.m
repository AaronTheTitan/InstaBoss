//
//  CameraViewController.m
//  InstaBoss
//
//  Created by Fiaz Sami on 2/3/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

#import <Parse/Parse.h>
#import "CameraViewController.h"

#import "Constants.h"
#import "HashTag.h"

@interface CameraViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageTarget;
@property (weak, nonatomic) IBOutlet UITextField *textFieldCaption;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.textFieldCaption.delegate = self;
    [self tapButtonCamera:nil];
}



- (IBAction)tapButtonCamera:(UIButton *)sender {
    if([self isCameraEnabled]) {
        [self showSourcePicker:UIImagePickerControllerSourceTypeCamera];
    }
}

- (IBAction)tapButtonCaption:(UIButton *)sender {
    [self textFieldShouldReturn:self.textFieldCaption];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(self.imageTarget.image) {
        [self saveImage:textField.text];
        textField.text = nil;
    }

    [textField resignFirstResponder];

    return YES;

}



- (void)saveImage:(NSString *)name {
    NSLog(@"%@", name);

    Photo *photo = [[Photo alloc] initPhoto];
    photo.caption = name;
    photo.image = self.imageTarget.image;
    photo.location = [self.delegate getLocation];
    [photo persist:^(BOOL succeeded, NSError *error) {
        if(succeeded) {
            NSLog(@"success");
        } else if(error) {
            UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Something went wrong, try again :(" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [myAlertView show];
        }

        self.imageTarget.image = nil;

        [self.delegate updateWithNewPhoto:photo];
    }];
}

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


- (IBAction)tapButtonSelectFromGallery:(UIButton *)sender {
    [self showSourcePicker:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageTarget.image = chosenImage;
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


@end
