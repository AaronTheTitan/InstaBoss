//
//  CustomFeedCell.h
//  InstaBoss
//
//  Created by Aaron Bradley on 2/6/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomFeedCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageViewFeedImage;
@property (strong, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) IBOutlet UILabel *likes;
@property (strong, nonatomic) IBOutlet UILabel *caption;

@end
