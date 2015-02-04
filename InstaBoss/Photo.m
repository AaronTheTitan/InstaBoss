//
//  Photo.m
//  InstaBoss
//
//  Created by Aaron Bradley on 2/3/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

#import "Photo.h"

@implementation Photo

- (instancetype)initWithParseObject:(PFObject *)parseObject {
    self = [super init];

    PFFile *imageFile = [parseObject objectForKey:@"Image"];

    self.caption = [parseObject objectForKey:@"Caption"];
    self.image = [UIImage imageWithData:[imageFile getData:nil]];

    


    return self;
}

@end
