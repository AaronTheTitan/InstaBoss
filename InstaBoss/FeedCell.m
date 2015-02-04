//
//  FeedCell.m
//  InstaBoss
//
//  Created by Fiaz Sami on 2/4/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

#import "FeedCell.h"

@implementation FeedCell

- (instancetype)initWithPhoto:(Photo *)photo {
    self = [super init];
    self.caption.text = photo.caption;
    self.photo.image = photo.image;
    return self;
}

@end
