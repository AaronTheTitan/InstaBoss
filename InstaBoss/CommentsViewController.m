//
//  CommentsViewController.m
//  InstaBoss
//
//  Created by Fiaz Sami on 2/4/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

#import "CommentsViewController.h"
#import "HashTag.h"

@interface CommentsViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imagePhoto;
@property (weak, nonatomic) IBOutlet UITableView *tableComments;
@property (strong, nonatomic) IBOutlet UITextField *textFieldEnterComment;

@property (weak, nonatomic) IBOutlet UIImageView *imageLike;

@end

@implementation CommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imagePhoto.image = self.photo.image;

    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(likePhoto)];
    tapRecognizer.numberOfTapsRequired = 2;
    tapRecognizer.numberOfTouchesRequired = 1;
    [self.imagePhoto addGestureRecognizer:tapRecognizer];


    self.imageLike.hidden = ![self.photo isLikedBy:[PFUser currentUser].username];
}

- (void)likePhoto {
    if(self.imageLike.hidden) {
        [self.photo.likes addObject:[PFUser currentUser].username];
        [self.photo likePhoto:nil];
    } else {
        [self.photo.likes removeObject:[PFUser currentUser].username];
        [self.photo likePhoto:nil];
    }

    
    self.imageLike.hidden = !self.imageLike.hidden;

}


- (IBAction)tapReturnToFeed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)tapButtonAddComment:(UIButton *)sender {
    [self textFieldShouldReturn:self.textFieldEnterComment];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField.text.length > 0) {
        [self.photo.comments addObject:textField.text];
        [self.photo saveComments:^(BOOL succeeded, NSError *error) {
            if(succeeded) {
                [HashTag persistHashTags:textField.text withObjectId:self.photo.photoId];
            }

            textField.text = nil;
        }];

        [self.tableComments reloadData];

    }

    [textField resignFirstResponder];

    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.photo.comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell" forIndexPath:indexPath];
    cell.textLabel.text = [self.photo.comments objectAtIndex:indexPath.row];

    return cell;
}

@end
