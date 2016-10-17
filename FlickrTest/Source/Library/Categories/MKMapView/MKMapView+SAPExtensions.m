//
//  MKMapView+SAPExtensions.m
//  TaskNavigator
//
//  Created by ASH on 9/29/16.
//  Copyright © 2016 Andrey. All rights reserved.
//

#import "MKMapView+SAPExtensions.h"

@implementation MKMapView (SAPExtensions)

- (void)zoomToUserLocation {
    MKUserLocation *location = self.userLocation;
    if (location) {
        CLLocationCoordinate2D coordinate = location.coordinate;
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 1000, 1000);
        [self setRegion:region animated:YES];
    }
}

@end
