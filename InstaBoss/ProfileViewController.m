//
//  SettingsViewController.m
//  InstaBoss
//
//  Created by Aaron Bradley on 2/4/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

#import "ProfileViewController.h"
#import "Constants.h"
#import "Photo.h"
#import "ImageCollectionViewCell.h"
#import "EditProfileViewController.h"

@interface ProfileViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

{
//    IBOutlet UITextField *textFieldDisplayName;
//    IBOutlet UITextField *textFieldProfileDescription;
//    IBOutlet UITextField *textFieldURL;
//
//    IBOutlet UIButton *buttonEditProfile;
//    IBOutlet UIButton *buttonTakePhoto;
//    IBOutlet UIButton *buttonAddPhoto;
//



    IBOutlet UILabel *userDisplayName;
    IBOutlet UILabel *userProfileDescription;
    IBOutlet UILabel *userURL;

    IBOutlet UILabel *labelFollowers;
    IBOutlet UILabel *labelFollowing;
//
//    BOOL isEditing;
//
//    IBOutlet UILabel *labelChangePassword;
//    IBOutlet UITextField *textFieldChangeEmail;
//    IBOutlet UITextField *textFieldCurrentPassword;
//    IBOutlet UITextField *textFieldNewPassword;
//    IBOutlet UITextField *textFieldConfirmNewPassword;

    IBOutlet UICollectionView *collectionViewPhotos;
    PFUser *currentUser;
    NSMutableArray *photos;
}

@property (strong, nonatomic) IBOutlet UIImageView *imageViewProfile;
@property (strong, nonatomic) IBOutlet UILabel *numberFollowing;
@property (strong, nonatomic) IBOutlet UILabel *numberOfFollowers;
@property (strong, nonatomic) IBOutlet UILabel *numberOfPosts;

@end


@implementation ProfileViewController
{
    NSMutableArray *following;
    NSMutableArray *followers;
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    [self hideEditFields];

    self.navigationItem.title = currentUser.username;

    PFQuery *socialProfile = [PFQuery queryWithClassName:kParseSocialObject];
    [socialProfile whereKey:@"username" equalTo:[PFUser currentUser].username];
    [socialProfile findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        following = objects.firstObject[@"Following"];
        followers = objects.firstObject[@"Followers"];
        labelFollowers.text = [NSString stringWithFormat:@"%li", followers.count];
        labelFollowing.text = [NSString stringWithFormat:@"%li", following.count];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    photos = [NSMutableArray new];
    currentUser = [PFUser currentUser];

    [currentUser[@"userPhoto"] getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if(!error) {
            self.imageViewProfile.image = [UIImage imageWithData:data];
        }
    }];

    userDisplayName.text = currentUser.username;
    userProfileDescription.text = currentUser[@"userDescription"];
    userURL.text = currentUser[@"url"];
//    labelFollowers.text = currentUser.
//    labelFollowing.text = currentUser.

    PFQuery *query = [PFQuery queryWithClassName:kParsePhotoObjectClass];
    [query whereKey:@"UserId" equalTo:currentUser.username];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for(PFObject *object in objects) {
                Photo *photo = [[Photo alloc] initWithParse:object];

                [photos addObject:photo];

            }

            [collectionViewPhotos reloadData];

        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellID" forIndexPath:indexPath];

    Photo *photo = [photos objectAtIndex:indexPath.row];
    NSLog(@"%@", photo.image.class);
    cell.imageViewCell.image = photo.image;
    return cell;
}


- (IBAction)tapButtonSignOut:(UIBarButtonItem *)sender {
    [PFUser logOut];
    [self dismissViewControllerAnimated:YES completion:nil];
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    EditProfileViewController *editVC = segue.destinationViewController;
//    editVC.currentUser = currentUser;
//
//}









@end
