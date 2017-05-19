//
//  MyWeatherAppViewController.h
//  MyWeatherApp
//
//  Created by Idris SOP on 2017/05/18.
//  Copyright © 2017 Idris SOP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMDCircleLoader.h"
#import "Reachability.h"

@interface MyWeatherAppViewController : UIViewController
@property (nonatomic) Reachability *hostReachability;
@property (nonatomic) Reachability *internetReachability;

@property (assign, nonatomic) BOOL isInternetReachable;
@property (assign, nonatomic) BOOL isHostReachable;
@property (strong, nonatomic) UIView *loadingView;

- (void)showLoading;
- (void)hideLoading;
- (void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message;

@end
