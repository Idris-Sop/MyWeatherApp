//
//  MyWeatherAppLocationManger.h
//  MyWeatherApp
//
//  Created by Idris SOP on 2017/05/18.
//  Copyright © 2017 Idris SOP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class MyWeatherAppLocationManger;

@protocol MyWeatherAppLocationMangerDelegate <NSObject>

- (void)doneGettingLocationCoordinates:(MyWeatherAppLocationManger *)myWeatherAppLocationManger;

@end

@interface MyWeatherAppLocationManger : CLLocationManager <CLLocationManagerDelegate>


@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic ,readonly) CLLocationCoordinate2D myLocation;
@property (nonatomic, weak) id <MyWeatherAppLocationMangerDelegate> myWeatherAppLocationManagerDelegate;

@end
