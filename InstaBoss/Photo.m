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

@interface Photo ()

@property NSString *objectId;

@end

@implementation Photo

- (instancetype)initPhoto {
    self = [super init];
    self.userId = @"";
    self.photoId = @"";
    self.caption = @"";
    self.comments = [NSMutableArray new];
    self.hashTags = [NSMutableArray new];
    self.likeCount = @0;

    return self;
}

- (instancetype)initWithParse:(PFObject *)parse {
    self = [super init];

    self.objectId = parse.objectId;


    self.userId = parse[@"UserId"];
    self.photoId = parse[@"PhotoId"];
    self.caption = parse[@"Caption"];
    self.comments = [BossObject convertArray:parse[@"Comments"]];
    self.hashTags = [BossObject convertArray:parse[@"HashTags"]];
    self.likeCount = parse[@"LikeCount"];

    self.image = [UIImage imageWithData:[parse[@"Image"] getData:nil]];

    return self;
}

- (void) persist:(void (^)(BOOL succeeded, NSError *error))completionMethod {
    PFObject *parse = [PFObject objectWithClassName:kParsePhotoObjectClass];
    self.comments = [NSMutableArray arrayWithArray:[[self.comments reverseObjectEnumerator] allObjects]];

    if(self.objectId) {
        parse.objectId = self.objectId;
    }

    if(self.image) {

        NSData *imageData = UIImagePNGRepresentation(self.image);
        parse[@"Image"] = [PFFile fileWithName:self.caption data:imageData];
    }

    parse[@"PhotoId"] = [BossObject generateID:[NSString stringWithFormat:@"%@%@", self.caption, [BossObject generateTimeStamp]]];

    parse[@"UserId"] = self.userId;
    parse[@"Caption"] = self.caption;
    parse[@"Comments"] = self.comments;
    parse[@"HashTags"] = self.hashTags;
    parse[@"LikeCount"] = self.likeCount;


    [parse saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(succeeded) {
        } else if(error) {
            UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Something went wrong, try again :(" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [myAlertView show];
        }

        if(completionMethod) {

            completionMethod(succeeded, error);
        }
        
    }];



}


@end
