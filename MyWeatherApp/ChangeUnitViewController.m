//
//  ChangeUnitViewController.m
//  MyWeatherApp
//
//  Created by Idris SOP on 2017/05/19.
//  Copyright © 2017 Idris SOP. All rights reserved.
//

#import "ChangeUnitViewController.h"

@interface ChangeUnitViewController ()

@end

@implementation ChangeUnitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"TemperatureUnit"] isEqualToString:@"metric"]) {
        [self.tempSegment setSelectedSegmentIndex:0];
    } else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"TemperatureUnit"] isEqualToString:@"imperial"]) {
        [self.tempSegment setSelectedSegmentIndex:1];
    }
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
    if (sender.selectedSegmentIndex == 0) {
        [[NSUserDefaults standardUserDefaults] setValue:@"metric" forKey:@"TemperatureUnit"];
        [[NSUserDefaults standardUserDefaults] setValue:@"°C" forKey:@"UnitSymbol"];
    } else if (sender.selectedSegmentIndex == 1) {
        [[NSUserDefaults standardUserDefaults] setValue:@"imperial" forKey:@"TemperatureUnit"];
        [[NSUserDefaults standardUserDefaults] setValue:@"°F" forKey:@"UnitSymbol"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
