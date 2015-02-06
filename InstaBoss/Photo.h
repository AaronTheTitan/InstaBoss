//
//  Photo.h
//  InstaBoss
//
//  Created by Aaron Bradley on 2/3/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

#import <Parse/Parse.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface Photo : NSObject

@property NSString *parseObjectId;
@property NSString *userId;
@property NSString *caption;

@property NSMutableArray *comments;
@property NSMutableArray *likes;

@property NSString *photoId;

@property UIImage *image;

@property NSNumber *latitude;
@property NSNumber *longitude;

@property NSNumber *likeCount;

@property MKPointAnnotation *location;

- (instancetype)initPhoto;
- (instancetype)initWithParse:(PFObject *)parse;

- (BOOL)isLikedBy:(NSString *)user;
- (void)likePhoto:(void (^)(BOOL succeeded, NSError *error))completionMethod;

- (void) persist:(void (^)(BOOL succeeded, NSError *error))completionMethod;
- (void) saveComments:(void (^)(BOOL succeeded, NSError *error))completionMethod;

@end
