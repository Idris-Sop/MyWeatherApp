//
//  SelectCityViewController.h
//  MyWeatherApp
//
//  Created by Idris SOP on 2017/05/18.
//  Copyright © 2017 Idris SOP. All rights reserved.
//

#import "MyWeatherAppViewController.h"
#import "MPGTextField.h"


@interface SelectCityViewController : MyWeatherAppViewController <UITextFieldDelegate, MPGTextFieldDelegate>

@property (strong, nonatomic) IBOutlet MPGTextField *cityTF;
@property (strong, nonatomic) IBOutlet UIButton *saveBtn;
//@property (strong, nonatomic) NSMutableArray *cityData;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (assign, nonatomic) BOOL isFromSetting;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)save:(id)sender;
@end
