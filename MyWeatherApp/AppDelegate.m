//
//  AppDelegate.m
//  MyWeatherApp
//
//  Created by Idris SOP on 2017/05/18.
//  Copyright © 2017 Idris SOP. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end


@implementation AppDelegate
@synthesize cityDict;
@synthesize cityData;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [Fabric with:@[[Digits class]]];
    [self generateData];
    
    self.cityDict = [[NSMutableDictionary alloc]init];
    
    [[NSUserDefaults standardUserDefaults] setValue:@"metric" forKey:@"TemperatureUnit"];
    [[NSUserDefaults standardUserDefaults] setValue:@"°C" forKey:@"UnitSymbol"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return YES;
}

+ (AppDelegate*)GetAppDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication]delegate];
}

- (void)generateData {
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Add code here to do background processing
        //
        //
        NSError* err = nil;
        self.cityData = [[NSMutableArray alloc] init];
        
        NSString* dataPath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"json"];
        NSArray* contents = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:dataPath] options:kNilOptions error:&err];
        dispatch_async( dispatch_get_main_queue(), ^{
            // Add code here to update the UI/send notifications based on the
            // results of the background processing
            [contents enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [self.cityData addObject:[NSDictionary dictionaryWithObjectsAndKeys:[[obj objectForKey:@"name"] stringByAppendingString:[NSString stringWithFormat:@", %@", [obj objectForKey:@"country"]]], @"DisplayText", [obj objectForKey:@"id"], @"CityId", nil]];
                
                //NSLog(@"Data: %@", self.cityData);
            }];
        });
    });
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    
}



@end
