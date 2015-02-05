//
//  HashTag.m
//  InstaBoss
//
//  Created by Fiaz Sami on 2/4/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

#import "HashTag.h"
#import "BossObject.h"
#import "Constants.h"

@interface HashTag ()

@property PFObject *parseObject;

@end

@implementation HashTag

- (instancetype) init {
    self = [super init];
    self.parseObject = [PFObject objectWithClassName:kParseHashTagObjectClass];
    self.items = [NSMutableArray new];

    return self;
}

- (instancetype)initWithParse:(PFObject *)parse {
    self = [super init];

    self.parseObject = parse;

    self.tag = parse[@"Tag"];
    self.items = [BossObject convertArray:parse[@"Items"]];

    return self;
}

- (BOOL)isMatch:(NSString *)match {
    if ([self.tag rangeOfString:match].location == NSNotFound) {
        return NO;
    } else {
        return YES;
    }
}

- (void) persist:(void (^)(BOOL succeeded, NSError *error))completionMethod {

    self.parseObject[@"Tag"] = self.tag;
    self.parseObject[@"Items"] = self.items;
    self.parseObject[@"Count"] = [NSNumber numberWithInt:(int)self.items.count];


    [self.parseObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(error) {
            UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Something went wrong, try again :(" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [myAlertView show];
        }

        if(completionMethod) {
            completionMethod(succeeded, error);
        }
        
    }];
}

- (void)addPhotoObjectId:(NSString *)objectId {
    if(![self.items containsObject:objectId]) {

        [self.items addObject:objectId];

        [self persist:nil];
    }
}

+ (void)persistHashTags:(NSString *)input withObjectId:(NSString *)objectId {
    NSArray *toks = [input componentsSeparatedByString:@" "];
    NSMutableArray *tags = [NSMutableArray new];
    for(NSString *tok in toks) {
        if([tok containsString:@"#"]) {
            [tags addObject:[tok stringByReplacingOccurrencesOfString:@"#" withString:@""]];
        }
    }

    NSLog(@"%@\t%@", objectId, toks);

    if(tags.count > 0) {
        PFQuery *query = [PFQuery queryWithClassName:kParseHashTagObjectClass];

            [query whereKey:@"Tag" containedIn:tags];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (error) {
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                } else {
                    for(PFObject *obj in objects) {
                        HashTag *hashTag = [[HashTag alloc] initWithParse:obj];
                        [hashTag addPhotoObjectId:objectId];
                        [tags removeObject:hashTag.tag];
                    }

                    for(NSString *tag in tags) {
                        HashTag *hashTag = [[HashTag alloc] init];
                        hashTag.tag = tag;
                        [hashTag addPhotoObjectId:objectId];
                    }

                }
        }];


    }
}

@end
