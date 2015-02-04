//
//  BossObject.m
//  InstaBoss
//
//  Created by Fiaz Sami on 2/4/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>

#import "BossObject.h"

@implementation BossObject

+ (NSString *)generateTimeStamp {
    return [[NSDate date] description];
}

+ (NSString*) generateID:(NSString *)input {
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];

    uint8_t digest[CC_SHA1_DIGEST_LENGTH];

    CC_SHA1(data.bytes, (int)data.length, digest);

    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];

    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];

    return output;

}

+ (NSString*) generateID {
    return [self generateID:[BossObject generateTimeStamp]];
}

@end
