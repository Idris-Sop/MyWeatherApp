//
//  WeatherViewController.m
//  MyWeatherApp
//
//  Created by Idris SOP on 2017/05/18.
//  Copyright © 2017 Idris SOP. All rights reserved.
//

#import "WeatherViewController.h"

@interface WeatherViewController ()

@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *narBarImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    UIImage *narBarImage = [UIImage imageNamed:@"weatherIcon"];
    [narBarImageView setImage:narBarImage];
    [self.navigationItem setTitleView:narBarImageView];
    
    [self performSelector:@selector(updateCurrentLocationWeather) withObject:self afterDelay:500.0f];
    [self performSelector:@selector(updateChosenCityWeather) withObject:self afterDelay:500.0f];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    self.locationManager = [[MyWeatherAppLocationManger alloc]init];
    [self.locationManager setMyWeatherAppLocationManagerDelegate:self];
    [self.locationManager startUpdatingLocation];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: @"EEEE, MMM d, yyyy"];
    
    NSString *dateString = [formatter stringFromDate: [NSDate date]];
    [self.currentDateLbl setText:[@"Today, " stringByAppendingString:dateString]];
    
    //[self updateCurrentLocationWeather];
    if (self.isFromSelectCity) {
        [self.selectionSegment setSelectedSegmentIndex:1];
        [self updateChosenCityWeather];
    } else {
        [self.selectionSegment setSelectedSegmentIndex:0];
    }
    self.isFromSelectCity = NO;
}

- (void)doneGettingLocationCoordinates:(MyWeatherAppLocationManger *)myWeatherAppLocationManger {
    [self updateCurrentLocationWeather];
}

- (void)updateCurrentLocationWeather {
    MyWeatherAppAPI *api = [MyWeatherAppAPI sharedMyWeatherAppAPI];
    if (self.isInternetReachable) {
        NSLog(@"Latttt: %@", [NSNumber numberWithDouble:[[[NSUserDefaults standardUserDefaults] valueForKey:@"latitude"] doubleValue]]);
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"latitude"] doubleValue] && [[[NSUserDefaults standardUserDefaults] valueForKey:@"longitude"] doubleValue]) {
            [self showLoading];
            NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
            [params setValue:[NSNumber numberWithDouble:[[[NSUserDefaults standardUserDefaults] valueForKey:@"latitude"] doubleValue]] forKey:@"lat"];
            [params setValue:[NSNumber numberWithDouble:[[[NSUserDefaults standardUserDefaults] valueForKey:@"longitude"] doubleValue]] forKey:@"lon"];
            [params setValue:API_KEY forKey:@"APPID"];
            [params setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"TemperatureUnit"] forKey:@"units"];
            
            [api getWeatherInfoFromServer:YES WithParams:params withCompletion:^(BOOL success, NSObject *currentWeatherInfo, NSString *message) {
                if (success) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self hideLoading];
                        NSMutableDictionary *mainDict = [[NSMutableDictionary alloc]init];
                        mainDict = [currentWeatherInfo valueForKey:@"main"];
                        
                        NSMutableDictionary *sysDict = [[NSMutableDictionary alloc]init];
                        sysDict = [currentWeatherInfo valueForKey:@"sys"];
                        
                        [self.currentLocation setText:[[[currentWeatherInfo valueForKey:@"name"] stringByAppendingString:@", "] stringByAppendingString:[sysDict valueForKey:@"country"]]];
                        
                        [self.currentTempLbl setText:[[NSString stringWithFormat:@"%d", [[mainDict valueForKey:@"temp"] intValue]] stringByAppendingString:[[NSUserDefaults standardUserDefaults] valueForKey:@"UnitSymbol"]]];
                        [self.minTempLbl setText:[[NSString stringWithFormat:@"%d", [[mainDict valueForKey:@"temp_min"] intValue]] stringByAppendingString:[[NSUserDefaults standardUserDefaults] valueForKey:@"UnitSymbol"]]];
                        [self.maxTempLbl setText:[[NSString stringWithFormat:@"%d", [[mainDict valueForKey:@"temp_max"] intValue]] stringByAppendingString:[[NSUserDefaults standardUserDefaults] valueForKey:@"UnitSymbol"]]];
                        [self hideLoading];
                        [self hideLoading];
                    });
                }
            }];
        } else {
            UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Location Access"
                                                                                message:@"In other to get the weather information of you current location, you need to provide your current location coordinates. Please go to Settings on your phone, scroll down, Select MyWeatherApp, then Allow Locations Access"
                                                                         preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK"
                                                                  style:UIAlertActionStyleDefault
                                                                handler:^(UIAlertAction *action) {
                                                                    NSLog(@"Dismiss button tapped!");
                                                                }];
            
            UIAlertAction *settingAction = [UIAlertAction actionWithTitle:@"Settings"
                                                                    style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction *action) {
                                                                      NSLog(@"Open Setting!");
                                                                      [self openSettings];
                                                                  }];
            [controller addAction:alertAction];
            [controller addAction:settingAction];
            [self presentViewController:controller animated:YES completion:nil];
        }
        
    } else {
         [self showAlertWithTitle:@"Could not connect to the server. \n Please check your internet connection" andMessage:@""];
    }
    [self hideLoading];
}

- (void)openSettings {
    BOOL canOpenSettings = (&UIApplicationOpenSettingsURLString != NULL);
    if (canOpenSettings) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (void)updateChosenCityWeather {
    MyWeatherAppAPI *api = [MyWeatherAppAPI sharedMyWeatherAppAPI];
    if (self.isInternetReachable) {
        [self showLoading];
        NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
        [params setValue:[NSNumber numberWithInteger:[[[NSUserDefaults standardUserDefaults] valueForKey:@"CityId"] integerValue]] forKey:@"id"];
        [params setValue:API_KEY forKey:@"APPID"];
        [params setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"TemperatureUnit"] forKey:@"units"];
        
        [api getWeatherInfoFromServer:YES WithParams:params withCompletion:^(BOOL success, NSObject *currentWeatherInfo, NSString *message) {
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSMutableDictionary *mainDict = [[NSMutableDictionary alloc]init];
                    mainDict = [currentWeatherInfo valueForKey:@"main"];
                    
                    NSMutableDictionary *sysDict = [[NSMutableDictionary alloc]init];
                    sysDict = [currentWeatherInfo valueForKey:@"sys"];
                    
                    [self.currentLocation setText:[[[currentWeatherInfo valueForKey:@"name"] stringByAppendingString:@", "] stringByAppendingString:[sysDict valueForKey:@"country"]]];
                    
                    [self.currentTempLbl setText:[[NSString stringWithFormat:@"%d", [[mainDict valueForKey:@"temp"] intValue]] stringByAppendingString:[[NSUserDefaults standardUserDefaults] valueForKey:@"UnitSymbol"]]];
                    [self.minTempLbl setText:[[NSString stringWithFormat:@"%d", [[mainDict valueForKey:@"temp_min"] intValue]] stringByAppendingString:[[NSUserDefaults standardUserDefaults] valueForKey:@"UnitSymbol"]]];
                    [self.maxTempLbl setText:[[NSString stringWithFormat:@"%d", [[mainDict valueForKey:@"temp_max"] intValue]] stringByAppendingString:[[NSUserDefaults standardUserDefaults] valueForKey:@"UnitSymbol"]]];
                    [self hideLoading];
                    [self hideLoading];
                });
            }
        }];
    } else {
        [self showAlertWithTitle:@"Could not connect to the server. \n Please check your internet connection" andMessage:@""];
    }
    [self hideLoading];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)segmentChanged:(UISegmentedControl *)sender {
    NSLog(@"Sender: %ld", (long)sender.selectedSegmentIndex);
    if (sender.selectedSegmentIndex == 0) {
        [self updateCurrentLocationWeather];
    } else if (sender.selectedSegmentIndex == 1) {
        NSLog(@"isCitySelected: %d", [[[NSUserDefaults standardUserDefaults] valueForKey:@"isCitySelected"] boolValue]);
        if(![[[NSUserDefaults standardUserDefaults] valueForKey:@"isCitySelected"] boolValue]) {
            UIStoryboard *mainstoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            SelectCityViewController *selectCityVC = [mainstoryboard instantiateViewControllerWithIdentifier:@"SelectCity"];
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:selectCityVC];
            [self presentViewController:navController animated:YES completion:nil];
            self.isFromSelectCity = YES;
        }
        [self updateChosenCityWeather];
    }
}
@end
