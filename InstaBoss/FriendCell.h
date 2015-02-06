//
//  FriendCell.h
//  InstaBoss
//
//  Created by Fiaz Sami on 2/6/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FriendCellDelegate <NSObject>

- (void) socializeWithUser;
- (void)cellDidOpen:(UITableViewCell *)cell;
- (void)cellDidClose:(UITableViewCell *)cell;

@end

@interface FriendCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *friendTextLabel;

@property (nonatomic, weak) id <FriendCellDelegate> delegate;

- (void)openCell;

@end
