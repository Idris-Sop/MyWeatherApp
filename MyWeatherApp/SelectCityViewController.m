//
//  SelectCityViewController.m
//  MyWeatherApp
//
//  Created by Idris SOP on 2017/05/18.
//  Copyright © 2017 Idris SOP. All rights reserved.
//

#import "SelectCityViewController.h"

@interface SelectCityViewController ()

@end

@implementation SelectCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Change City";
    [self.saveBtn setTintColor:[UIColor whiteColor]];
    [self.saveBtn.layer setCornerRadius:5.0];
    [self.cityTF setDelegate:self];
    [self.cityTF setBackgroundColor:[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0]];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark MPGTextField Delegate Methods

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.cityTF) {
        [self.scrollView setContentOffset: CGPointMake(0, 50) animated: YES];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.cityTF) {
        [self.scrollView setContentOffset: CGPointMake(0, -50.0) animated: YES];
    }
}

- (NSArray *)dataForPopoverInTextField:(MPGTextField *)textField {
    NSLog(@"String: %@", textField.text);
    if([textField.text length] >= 4) {
        [self performSelectorInBackground:@selector(ShowHideActivity:) withObject:@"YES"];
        return [AppDelegate GetAppDelegate].cityData;
    } else {
        return nil;
    }
    
}

-(void)ShowHideActivity:(NSString*)shouldShow{
    if([shouldShow isEqualToString:@"YES"]) {
        [self.activityIndicator startAnimating];
    }
    else {
        [self.activityIndicator stopAnimating];
    }
}

- (BOOL)textFieldShouldSelect:(MPGTextField *)textField {
    return YES;
}

- (void)textField:(MPGTextField *)textField didEndEditingWithSelection:(NSDictionary *)result {
    //A selection was made - either by the user or by the textfield. Check if its a selection from the data provided or a NEW entry.
    NSLog(@"result: %@", result);
    [self.cityTF setText:[result objectForKey:@"DisplayText"]];
    [[AppDelegate GetAppDelegate].cityDict setValue:[result objectForKey:@"CityId"] forKey:@"CityId"];
    [[AppDelegate GetAppDelegate].cityDict setValue:[result objectForKey:@"DisplayText"] forKey:@"CityName"];
    [self performSelectorInBackground:@selector(ShowHideActivity:) withObject:@"NO"];
    NSLog(@"[[AppDelegate GetAppDelegate].cityDict: %@", [AppDelegate GetAppDelegate].cityDict);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)save:(id)sender {
    if ([[AppDelegate GetAppDelegate].cityDict valueForKey:@"CityId"]) {
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:YES] forKey:@"isCitySelected"];
        [[NSUserDefaults standardUserDefaults] setValue:[[AppDelegate GetAppDelegate].cityDict valueForKey:@"CityId"] forKey:@"CityId"];
        [[NSUserDefaults standardUserDefaults] setValue:[[AppDelegate GetAppDelegate].cityDict valueForKey:@"CityName"] forKey:@"CityName"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        if (self.isFromSetting) {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    } else {
        [self showAlertWithTitle:@"Invalid City" andMessage:@"Please select a valid city from the drop down"];
    }
}

@end
