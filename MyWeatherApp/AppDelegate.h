//
//  AppDelegate.h
//  MyWeatherApp
//
//  Created by Idris SOP on 2017/05/18.
//  Copyright © 2017 Idris SOP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "SelectCityViewController.h"
#import <Fabric/Fabric.h>
#import <DigitsKit/DigitsKit.h>
#import <Crashlytics/Crashlytics.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableDictionary *cityDict;
@property (strong, nonatomic) NSMutableArray *cityData;

+(AppDelegate*)GetAppDelegate;
//- (void)saveContext;


@end

