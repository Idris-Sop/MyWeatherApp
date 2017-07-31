//
//  MyWeatherAppViewController.m
//  MyWeatherApp
//
//  Created by Idris SOP on 2017/05/18.
//  Copyright © 2017 Idris SOP. All rights reserved.
//

#import "MyWeatherAppViewController.h"

@interface MyWeatherAppViewController ()

@end

@implementation MyWeatherAppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
     NSString *remoteHostName = @"www.apple.com";
    self.hostReachability = [Reachability reachabilityWithHostName:remoteHostName];
    [self.hostReachability startNotifier];
    [self updateInterfaceWithReachability:self.hostReachability];
    
    self.internetReachability = [Reachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];
    [self updateInterfaceWithReachability:self.internetReachability];
}

- (void)showLoading {
    self.loadingView = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 100.0F) / 2.0F, (self.view.frame.size.height - 100.0F) / 2.0F, 100.0F, 100.0F)];
    [self.loadingView setBackgroundColor:[UIColor whiteColor]];
    [self.loadingView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self.loadingView.layer setCornerRadius:10];
    [self.loadingView.layer setMasksToBounds:YES];
    [self.loadingView.layer setBorderColor:[[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0] CGColor]];
    [self.loadingView.layer setBorderWidth:1.0];
    float height = [[UIScreen mainScreen] bounds].size.height;
    float width = [[UIScreen mainScreen] bounds].size.width;
    CGPoint center = CGPointMake(width/2, height/2);
    self.loadingView.center = center;
    [self.view addSubview:self.loadingView];
    [GMDCircleLoader setOnView:self.loadingView withTitle:@"Loading..." animated:YES];
    [self.view setUserInteractionEnabled:NO];
}

- (void)hideLoading {
    [GMDCircleLoader hideFromView:self.loadingView animated:YES];
    [self.loadingView removeFromSuperview];
    [self.view setUserInteractionEnabled:YES];
}

- (void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:title
                                                                        message:message
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK"
                                                          style:UIAlertActionStyleDestructive
                                                        handler:^(UIAlertAction *action) {
                                                            NSLog(@"Dismiss button tapped!");
                                                        }];
    
    [controller addAction:alertAction];
    
    [self presentViewController:controller animated:YES completion:nil];
}


- (void)stopCircleLoader {
    [GMDCircleLoader hideFromView:self.loadingView animated:YES];
    [self.loadingView removeFromSuperview];
}


#pragma mark - Reachability implementation

/*!
 * Called by Reachability whenever status changes.
 */
- (void) reachabilityChanged:(NSNotification *)note {
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self updateInterfaceWithReachability:curReach];
}


- (void)updateInterfaceWithReachability:(Reachability *)reachability {
    if (reachability == self.hostReachability) {
        //[self configureTextField:self.remoteHostStatusField imageView:self.remoteHostImageView reachability:reachability];
        NetworkStatus netStatus = [reachability currentReachabilityStatus];
        BOOL connectionRequired = [reachability connectionRequired];
        
        NSString* baseLabelText = @"";
        
        if (connectionRequired)
        {
            baseLabelText = @"Cellular data network is available.\nInternet traffic will be routed through it after a connection is established.";
        }
        else
        {
            baseLabelText = @"Cellular data network is active.\nInternet traffic will be routed through it.";
        }
    }
    
    if (reachability == self.internetReachability) {
        if (reachability.currentReachabilityStatus) {
            self.isInternetReachable = YES;
        } else {
            self.isInternetReachable = NO;
        }
    }
    NSLog(@"\nIsInternetReachable: %d", self.isInternetReachable);
    
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
