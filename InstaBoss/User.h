//
//  User.h
//  InstaBoss
//
//  Created by Aaron Bradley on 2/3/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property NSString *userName;
@property NSString *password;
@property NSString *emailAddress;

- (BOOL)isMatch:(NSString *)match;

@end
