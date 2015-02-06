//
//  User.m
//  InstaBoss
//
//  Created by Aaron Bradley on 2/3/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

#import <Parse/Parse.h>
#import "Constants.h"
#import "User.h"
#import "BossObject.h"

@implementation User

- (BOOL)isMatch:(NSString *)match {
    if ([self.userName rangeOfString:match].location == NSNotFound) {
        return NO;
    } else {
        return YES;
    }
}

+ (void)updateSocial:(NSString *)action withUser:(NSString *)targetUser {
    PFQuery *query = [PFQuery queryWithClassName:kParseSocialObject];
    NSString *currentUser = [PFUser currentUser].username;
    NSLog(@"%@ is %@ %@", [PFUser currentUser].username, action, targetUser);

    NSMutableArray *users = [NSMutableArray new];
    [users addObject:targetUser];
    [users addObject:currentUser];

    [query whereKey:@"username" containedIn:users];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        } else {
            for(PFObject *obj in objects) {
                if([targetUser isEqualToString:obj[@"username"]]) {
                    NSMutableArray *followers = obj[@"Followers"];
                    if([@"Follow" isEqualToString:action]) {
                        [followers addObject:currentUser];
                    } else {
                        [followers removeObject:currentUser];
                    }
                    obj[@"Followers"] = [BossObject convertArray:followers];
                    obj[@"username"] = targetUser;

                } else {
                    NSMutableArray *following = obj[@"Following"];
                    if([@"Follow" isEqualToString:action]) {
                        [following addObject:targetUser];
                    } else {
                        [following removeObject:targetUser];
                    }
                    obj[@"Following"] = [BossObject convertArray:following];
                    obj[@"username"] = currentUser;
                }

                [obj saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    //
                }];

                [users removeObject:obj[@"username"]];
            }

            for(NSString *user in users) {
                PFObject *obj = [PFObject objectWithClassName:kParseSocialObject];
                if([targetUser isEqualToString:user]) {
                    NSMutableArray *followers = [NSMutableArray new];
                    [followers addObject:currentUser];
                    obj[@"Followers"] = [BossObject convertArray:followers];
                    obj[@"username"] = targetUser;

                } else {
                    NSMutableArray *following = [NSMutableArray new];
                    [following addObject:targetUser];
                    obj[@"Following"] = [BossObject convertArray:following];
                    obj[@"username"] = currentUser;
                }


                [obj saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    //
                }];

            }
        }
    }];
}

@end
