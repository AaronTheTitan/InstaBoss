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
    self.userId = [PFUser currentUser].username;
    self.caption = @"";
    self.comments = [NSMutableArray new];
    self.likeCount = @0;
    return self;
}

- (instancetype)initWithParse:(PFObject *)parse {
    self = [super init];

    self.parseObject = parse;

    self.parseObjectId = parse.objectId;


    self.userId = parse[@"UserId"];
    self.caption = parse[@"Caption"];
    self.comments = [BossObject convertArray:parse[@"Comments"]];
    self.likeCount = parse[@"LikeCount"];

    self.photoId = parse[@"PhotoId"];

    self.image = [UIImage imageWithData:[parse[@"Image"] getData:nil]];

    return self;
}

- (void) saveComments:(void (^)(BOOL succeeded, NSError *error))completionMethod {
    self.comments = [NSMutableArray arrayWithArray:[[self.comments reverseObjectEnumerator] allObjects]];
    self.parseObject[@"Comments"] = self.comments;
    [self.parseObject saveInBackgroundWithBlock:nil];
}

- (void) persist:(void (^)(BOOL succeeded, NSError *error))completionMethod {
    PFObject *parse = [PFObject objectWithClassName:kParsePhotoObjectClass];


    self.photoId = [BossObject generateID:self.caption];

    if(self.image) {
        NSData *imageData = UIImagePNGRepresentation(self.image);
        parse[@"Image"] = [PFFile fileWithName:[BossObject generateID] data:imageData];
    }

    parse[@"UserId"] = self.userId;
    parse[@"Caption"] = self.caption;
    parse[@"Comments"] = self.comments;
    parse[@"LikeCount"] = self.likeCount;
    parse[@"PhotoId"] = self.photoId;


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
