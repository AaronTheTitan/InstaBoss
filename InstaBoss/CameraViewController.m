//
//  CameraViewController.m
//  InstaBoss
//
//  Created by Fiaz Sami on 2/3/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

#import "CameraViewController.h"

@interface CameraViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *viewCamera;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self isCameraEnabled];
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

- (IBAction)tapButtonTakePicture:(UIButton *)sender {
    if([self isCameraEnabled]) {
        [self showSourcePicker:UIImagePickerControllerSourceTypeCamera];
    }
}

- (IBAction)tapButtonSelectFromGallery:(UIButton *)sender {
    [self showSourcePicker:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.viewCamera.image = chosenImage;
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
    [self presentViewController:picker animated:YES completion:NULL];

}


@end
