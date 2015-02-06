//
//  User.m
//  InstaBoss
//
//  Created by Aaron Bradley on 2/3/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

#import "User.h"

@implementation User

- (BOOL)isMatch:(NSString *)match {
    if ([self.userName rangeOfString:match].location == NSNotFound) {
        return NO;
    } else {
        return YES;
    }
}

@end
