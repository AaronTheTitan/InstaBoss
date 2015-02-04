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

@implementation Photo

- (instancetype)initPhoto {
    self = [super init];
    self.userId = @"";
    self.photoId = @"";
    self.caption = @"";
    self.comments = [NSArray new];
    self.hashTags = [NSArray new];
    self.likeCount = @0;

    return self;
}

- (instancetype)initWithParse:(PFObject *)parse {
    self = [super init];

    self.userId = parse[@"UserId"];
    self.photoId = parse[@"PhotoId"];
    self.caption = parse[@"Caption"];
    self.comments = [BossObject convertArray:parse[@"Comments"]];
    self.hashTags = [BossObject convertArray:parse[@"HashTags"]];
    self.likeCount = parse[@"LikeCount"];

    self.image = [UIImage imageWithData:[parse[@"Image"] getData:nil]];

    NSLog(@"%@", self.comments);

    return self;
}

- (void) saveToParse:(void (^)(BOOL succeeded, NSError *error))completionMethod {
    PFObject *parse = [PFObject objectWithClassName:kParsePhotoObjectClass];
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

        completionMethod(succeeded, error);
        
    }];

}


@end
