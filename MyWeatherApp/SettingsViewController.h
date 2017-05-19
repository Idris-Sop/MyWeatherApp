//
//  SettingsViewController.h
//  MyWeatherApp
//
//  Created by Idris SOP on 2017/05/18.
//  Copyright © 2017 Idris SOP. All rights reserved.
//

#import "MyWeatherAppViewController.h"
#import "SelectCityViewController.h"
#import "ChangeUnitViewController.h"


@interface SettingsViewController : MyWeatherAppViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *settingTable;
@property (strong, nonatomic) NSMutableArray *contentParts;

@end
