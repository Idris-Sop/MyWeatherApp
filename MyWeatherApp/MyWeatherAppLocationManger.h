//
//  MyWeatherAppLocationManger.h
//  MyWeatherApp
//
//  Created by Idris SOP on 2017/05/18.
//  Copyright © 2017 Idris SOP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MyWeatherAppLocationManger : CLLocationManager <CLLocationManagerDelegate>


@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic ,readonly) CLLocationCoordinate2D myLocation;
@end
