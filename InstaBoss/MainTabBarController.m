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
#import "SearchViewController.h"
#import "Locator.h"

@interface MainTabBarController () <CameraViewControllerDelegate, SearchViewControllerDelegate>

@property (strong, nonatomic) FeedViewController *feed;
@property (strong, nonatomic) CameraViewController *camera;
@property (strong, nonatomic) SearchViewController *search;

@property Locator *locator;

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.feed = [self.viewControllers objectAtIndex:0];
    self.camera = [self.viewControllers objectAtIndex:2];
    self.search = [self.viewControllers objectAtIndex:3];

    self.camera.delegate = self;
    self.search.delegate = self;
    self.locator = [Locator new];
    [self.locator updateLocation];
}

- (void)updateWithNewPhoto:(Photo *)photo {
    self.selectedIndex = 0;
}

- (void)displayHashTag:(HashTag *)hashTag {
    self.selectedIndex = 0;
    [self.feed loadFeedWithHashTag:hashTag];
}

- (MKPointAnnotation *)getLocation {
    return self.locator.currentLocation;
}

@end
