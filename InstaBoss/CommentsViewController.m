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

@end

@implementation CommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imagePhoto.image = self.photo.image;
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
        [self.photo persist:^(BOOL succeeded, NSError *error) {
            if(succeeded) {
                [HashTag persistHashTags:textField.text withObjectId:self.photo.parseObjectId];
            }
        }];

        [self.tableComments reloadData];
        textField.text = nil;
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
