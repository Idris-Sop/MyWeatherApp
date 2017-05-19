//
//  MyWeatherAppLocationManger.m
//  MyWeatherApp
//
//  Created by Idris SOP on 2017/05/18.
//  Copyright © 2017 Idris SOP. All rights reserved.
//

#import "MyWeatherAppLocationManger.h"

@implementation MyWeatherAppLocationManger

- (id)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    self.locationManager = [[CLLocationManager alloc]init];
    [self.locationManager setDelegate:self];
    [self.locationManager setDistanceFilter: kCLDistanceFilterNone];
    [self.locationManager setDesiredAccuracy: kCLLocationAccuracyBest];
    
    if ([[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:(NSOperatingSystemVersion){.majorVersion = 8, .minorVersion = 1, .patchVersion = 0}]) {
        NSLog(@"Hello from > iOS 8.1");
        if( [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined){
            [self.locationManager requestWhenInUseAuthorization];
            [self.locationManager requestAlwaysAuthorization];
            [self.locationManager startUpdatingLocation];
            //self.locationManager.allowsBackgroundLocationUpdates = YES;
        }
    } else {
        [self.locationManager startUpdatingLocation];
    }
    
    //    if ([operatingSystemVersionString floatValue] >= 8.0) {
    //        if( [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined){
    //            [self.locationManager requestWhenInUseAuthorization];
    //            [self.locationManager requestAlwaysAuthorization];
    //            [self.locationManager startUpdatingLocation];
    //        }
    //    } else {
    //        [self.locationManager startUpdatingLocation];
    //    }
    
    //[self performSelector:@selector(startUpdatingLocation) withObject:nil afterDelay:5.0];
    return self;
}


- (void)startUpdatingLocation {
    [[self locationManager] startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    _myLocation = CLLocationCoordinate2DMake(newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithFloat:_myLocation.latitude] forKey:@"latitude"];
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithFloat:_myLocation.longitude] forKey:@"longitude"];
    
    NSLog(@"UPDATED LATITUDE %f = AND LONGITUDE %f =", _myLocation.latitude, _myLocation.longitude);
    if (_myLocation.latitude && _myLocation.longitude) {
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:YES] forKey:@"isUserHasLocation"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    [[self locationManager] stopUpdatingLocation];
    
    if ([self.myWeatherAppLocationManagerDelegate respondsToSelector:@selector(doneGettingLocationCoordinates:)]) {
        [self.myWeatherAppLocationManagerDelegate doneGettingLocationCoordinates:self];
    }
}

@end
