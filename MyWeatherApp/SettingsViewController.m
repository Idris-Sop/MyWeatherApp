//
//  SettingsViewController.m
//  MyWeatherApp
//
//  Created by Idris SOP on 2017/05/18.
//  Copyright © 2017 Idris SOP. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Settings";
    
    [self.settingTable setDelegate:self];
    [self.settingTable setDataSource:self];
    self.settingTable.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    [self.settingTable setScrollEnabled:NO];
    [self.settingTable setContentInset:UIEdgeInsetsMake(0.0, 0.0, 20.0, 0.0)];
    [self.settingTable setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.settingTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    self.contentParts = [[NSMutableArray alloc]init];
    [self.contentParts addObject: @{@"image": @"", @"label": @"Change Unit"}];
    [self.contentParts addObject: @{@"image": @"", @"label": @"Change City"}];
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"Number of rows: %lu", (unsigned long)[self.contentParts count]);
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.contentParts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *customCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [customCell.textLabel setText:[[self.contentParts objectAtIndex:indexPath.section] valueForKey:@"label"]];
    [customCell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return customCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[[self.contentParts valueForKey:@"label"] objectAtIndex:indexPath.section] isEqualToString:@"Change Unit"]) {
        [self changeUnit];
    } else  if ([[[self.contentParts valueForKey:@"label"] objectAtIndex:indexPath.section] isEqualToString:@"Change City"]) {
        [self changeCity];
    }
}

- (void)changeCity {
    UIStoryboard *mainstoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SelectCityViewController *selectCityVC = [mainstoryboard instantiateViewControllerWithIdentifier:@"SelectCity"];
    selectCityVC.isFromSetting = YES;
    [self.navigationController pushViewController:selectCityVC animated:YES];
}

- (void)changeUnit {
    ChangeUnitViewController *changeUnitVC = [[ChangeUnitViewController alloc]initWithNibName:@"ChangeUnitViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:changeUnitVC animated:YES];
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

@end
