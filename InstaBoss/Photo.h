//
//  Photo.h
//  InstaBoss
//
//  Created by Aaron Bradley on 2/3/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface Photo : NSObject

@property NSString *caption;
@property UIImage *image;

- (instancetype)initWithParseObject:(PFObject *)parseObject;

@end
