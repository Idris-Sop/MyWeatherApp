//
//  WeatherViewController.h
//  MyWeatherApp
//
//  Created by Idris SOP on 2017/05/18.
//  Copyright © 2017 Idris SOP. All rights reserved.
//

#import "MyWeatherAppViewController.h"

@interface WeatherViewController : MyWeatherAppViewController
@property (strong, nonatomic) IBOutlet UILabel *currentDateLbl;
@property (strong, nonatomic) IBOutlet UILabel *currentTempLbl;
@property (strong, nonatomic) IBOutlet UILabel *minTempLbl;
@property (strong, nonatomic) IBOutlet UILabel *maxTempLbl;
@property (strong, nonatomic) IBOutlet UILabel *currentLocation;
@property (strong, nonatomic) IBOutlet UISegmentedControl *selectionSegment;

- (IBAction)segmentChanged:(UISegmentedControl *)sender;

@end
