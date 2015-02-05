//
//  CameraViewController.h
//  InstaBoss
//
//  Created by Fiaz Sami on 2/3/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@protocol CameraViewControllerDelegate <NSObject>

- (void)updateWithNewPhoto:(Photo *)photo;

@end

@interface CameraViewController : UIViewController

@property id<CameraViewControllerDelegate> delegate;

@end

