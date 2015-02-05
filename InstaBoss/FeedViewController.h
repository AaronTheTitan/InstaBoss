//
//  FeedViewController.h
//  InstaBoss
//
//  Created by Aaron Bradley on 2/3/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HashTag.h"

@interface FeedViewController : UIViewController

- (void)loadFeedWithHashTag:(HashTag *)hashTag;

@end
