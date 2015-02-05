//
//  CommentsViewController.m
//  InstaBoss
//
//  Created by Fiaz Sami on 2/4/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

#import "CommentsViewController.h"

@interface CommentsViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imagePhoto;
@property (weak, nonatomic) IBOutlet UITableView *tableComments;

@end

@implementation CommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imagePhoto.image = self.photo.image;
}

- (IBAction)tapReturnToFeed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField.text.length > 0) {
        [self.photo.comments addObject:textField.text];
        [self.photo persist:nil];
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
