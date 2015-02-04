//
//  FeedCell.h
//  InstaBoss
//
//  Created by Fiaz Sami on 2/4/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Photo.h"

@interface FeedCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photo;

@property (weak, nonatomic) IBOutlet UILabel *caption;

- (instancetype)initWithPhoto:(Photo *)photo;

@end
