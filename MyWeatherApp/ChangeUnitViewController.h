//
//  ChangeUnitViewController.h
//  MyWeatherApp
//
//  Created by Idris SOP on 2017/05/19.
//  Copyright © 2017 Idris SOP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeUnitViewController : UIViewController
@property (strong, nonatomic) IBOutlet UISegmentedControl *tempSegment;
- (IBAction)segmentChanged:(UISegmentedControl *)sender;


@end
