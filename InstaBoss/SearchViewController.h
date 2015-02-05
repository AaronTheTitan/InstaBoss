//
//  SearchViewController.h
//  InstaBoss
//
//  Created by Aaron Bradley on 2/5/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HashTag.h"

@protocol SearchViewControllerDelegate <NSObject>

- (void)displayHashTag:(HashTag *)hashTag;

@end

@interface SearchViewController : UIViewController

@property id<SearchViewControllerDelegate> delegate;

@end
