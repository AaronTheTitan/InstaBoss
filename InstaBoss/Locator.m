//
//  Locator.m
//  InstaBoss
//
//  Created by Fiaz Sami on 2/5/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "Locator.h"

@interface Locator () <CLLocationManagerDelegate>

@property CLLocationManager *locationManager;

@end

@implementation Locator



- (void)updateLocation {
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    for(CLLocation *location in locations) {
        if(location.horizontalAccuracy < 1000 && location.verticalAccuracy < 1000) {
            [self.locationManager stopUpdatingLocation];
            CLGeocoder *coder = [CLGeocoder new];
            [coder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {

                self.currentLocation = [[MKPointAnnotation alloc] init];
                self.currentLocation.title = @"Current Location";
                self.currentLocation.coordinate = ((CLLocation *)[locations lastObject]).coordinate;
            }];
            
        }
    }
}



@end
