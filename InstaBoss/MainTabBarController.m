//
//  MainTabBarController.m
//  InstaBoss
//
//  Created by Fiaz Sami on 2/4/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

#import "MainTabBarController.h"
#import "FeedViewController.h"
#import "CameraViewController.h"

@interface MainTabBarController () <CameraViewProtocol>

@property (strong, nonatomic) FeedViewController *feed;
@property (strong, nonatomic) CameraViewController *camera;

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.feed = [self.viewControllers objectAtIndex:0];
    self.camera = [self.viewControllers objectAtIndex:2];

    self.camera.delegate = self;
}

- (void)updateWithNewPhoto:(Photo *)photo {
    NSLog(@"delegate called");
    [self.feed loadFeed];
    self.selectedIndex = 0;
}


@end
