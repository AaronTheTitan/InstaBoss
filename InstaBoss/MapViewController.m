//
//  MapViewController.m
//  InstaBoss
//
//  Created by Fiaz Sami on 2/5/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <Parse/Parse.h>
#import "Constants.h"
#import "MapViewController.h"
#import "Photo.h"

@interface MapViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapPhotos;

@end


@implementation MapViewController
{
    NSMutableArray *photos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadMap];
}

- (void)loadMap {

    PFQuery *query = [PFQuery queryWithClassName:kParsePhotoObjectClass];
    [query whereKey:@"UserId" equalTo:self.user.userName];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for(PFObject *object in objects) {
                Photo *photo = [[Photo alloc] initWithParse:object];
                [photos addObject:photo];
                [self.mapPhotos addAnnotation:photo.location];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }

        [self.mapPhotos showAnnotations:self.mapPhotos.annotations animated:YES];
    }];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
    pin.canShowCallout = YES;
    return pin;
}

- (IBAction)tapButtonDismiss:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
