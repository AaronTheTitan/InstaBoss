//
//  ViewController.m
//  InstaBoss
//
//  Created by Aaron Bradley on 2/3/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

#import "HomeViewController.h"
#import "Photo.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
//    testObject[@"foo"] = @"bar";
//    [testObject saveInBackground];



}

//- (IBAction)selectPhoto:(UIButton *)sender {
//
//    UIImagePickerController *picker = [UIImagePickerController new];
//    picker.delegate = self;
//    picker.allowsEditing = YES;
//    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//
//    [self presentViewController:picker animated:YES completion:NULL];
//}
//
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
//
////    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
//    Photo *photo = [Photo new];
//
////    PFObject *photo = [PFObject objectWithClassName:@"Photo"];
//
//    photo.photo = info[UIImagePickerControllerEditedImage];
//    self.imageViewMain.image = photo;
//
//    [picker dismissViewControllerAnimated:YES completion:NULL];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
