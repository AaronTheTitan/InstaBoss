//
//  Photo.m
//  InstaBoss
//
//  Created by Aaron Bradley on 2/3/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//


#import "Constants.h"
#import "Photo.h"
#import "BossObject.h"
#import "HashTag.h"

@interface Photo ()

@property PFObject *parseObject;

@end

@implementation Photo

- (instancetype)initPhoto {
    self = [super init];
    self.caption = @"";
    self.comments = [NSMutableArray new];
    self.likes = [NSMutableArray new];
    return self;
}

- (instancetype)initWithParse:(PFObject *)parse {
    self = [super init];

    self.parseObject = parse;

    self.parseObjectId = parse.objectId;


    self.userId = parse[@"UserId"];
    self.caption = parse[@"Caption"];

    self.photoId = parse[@"PhotoId"];

    self.latitude = parse[@"Latitude"];
    self.longitude = parse[@"Longitude"];


    self.comments = [BossObject convertArray:parse[@"Comments"]];
    
    self.likes = [BossObject convertArray:parse[@"Likes"]];

    self.image = [UIImage imageWithData:[self.parseObject[@"Image"] getData:nil]];

    self.location = [[MKPointAnnotation alloc] init];
    self.location.title = self.caption;
    self.location.coordinate = CLLocationCoordinate2DMake([self.latitude doubleValue], [self.longitude doubleValue]);
    
    return self;
}

- (void)likePhoto:(void (^)(BOOL succeeded, NSError *error))completionMethod {
    self.likes = [NSMutableArray arrayWithArray:[[self.likes reverseObjectEnumerator] allObjects]];
    self.parseObject[@"Likes"] = self.likes;
    [self.parseObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(completionMethod) {
            completionMethod(succeeded, error);
        }
    }];
}

- (void) saveComments:(void (^)(BOOL succeeded, NSError *error))completionMethod {
    self.comments = [NSMutableArray arrayWithArray:[[self.comments reverseObjectEnumerator] allObjects]];
    self.parseObject[@"Comments"] = self.comments;
    [self.parseObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(completionMethod) {
            completionMethod(succeeded, error);
        }
    }];
}

- (BOOL)isLikedBy:(NSString *)user {
    for(int i = 0 ; i < self.likes.count ; i++) {
        if([self.likes[i] isEqualToString:user]) {
            return YES;
        }
    }

    return NO;
}

- (void) persist:(void (^)(BOOL succeeded, NSError *error))completionMethod {
    PFObject *parse = [PFObject objectWithClassName:kParsePhotoObjectClass];

    self.photoId = [BossObject generateID:self.caption];

    self.latitude = [NSNumber numberWithDouble:self.location.coordinate.latitude];
    self.longitude = [NSNumber numberWithDouble:self.location.coordinate.longitude];

    if(self.image) {
        NSData *imageData = UIImagePNGRepresentation(self.image);
        parse[@"Image"] = [PFFile fileWithName:[BossObject generateID] data:imageData];
    }

    parse[@"UserId"] = [PFUser currentUser].username;
    parse[@"Caption"] = self.caption;
    parse[@"PhotoId"] = self.photoId;
    parse[@"Latitude"] = self.latitude;
    parse[@"Longitude"] = self.longitude;

    
    parse[@"Comments"] = self.comments;
    parse[@"Likes"] = self.likes;

    [parse saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(succeeded) {
        } else if(error) {
            UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Something went wrong, try again :(" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [myAlertView show];
        }

        if(completionMethod) {

            completionMethod(succeeded, error);
        }

        [HashTag persistHashTags:self.caption withObjectId:self.photoId];
        
    }];
}


@end
