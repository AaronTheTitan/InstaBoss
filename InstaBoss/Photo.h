//
//  Photo.h
//  InstaBoss
//
//  Created by Aaron Bradley on 2/3/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

#import <Parse/Parse.h>
#import <UIKit/UIKit.h>

@interface Photo : NSObject

@property NSString *userId;
@property NSString *photoId;
@property NSString *caption;
@property NSArray *comments;
@property NSArray *hashTags;
@property NSNumber *likeCount;

@property UIImage *image;

- (instancetype)initPhoto;
- (instancetype)initWithParse:(PFObject *)parse;
- (void) saveToParse:(void (^)(BOOL succeeded, NSError *error))completionMethod;


@end
