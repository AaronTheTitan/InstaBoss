//
//  BossObject.h
//  InstaBoss
//
//  Created by Fiaz Sami on 2/4/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BossObject : NSObject



+ (NSMutableArray *)convertArray:(NSMutableArray *)input;
+ (NSString *)generateTimeStamp;
+ (NSString *)generateID;
+ (NSString *)generateID:(NSString *)input;

@end
