//
//  Locator.h
//  InstaBoss
//
//  Created by Fiaz Sami on 2/5/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Locator : NSObject

@property MKPointAnnotation *currentLocation;

- (void)updateLocation;

@end
