//
//  HashTag.h
//  InstaBoss
//
//  Created by Fiaz Sami on 2/4/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"

@interface HashTag : NSObject

@property NSString *tag;
@property NSMutableArray *items;

- (instancetype)initWithParse:(PFObject *)parse;
- (BOOL)isMatch:(NSString *)match;

+ (void)persistHashTags:(NSString *)input withObjectId:(NSString *)objectId;

@end
