//
//  MyWeatherAppAPI.h
//  MyWeatherApp
//
//  Created by Idris SOP on 2017/05/18.
//  Copyright © 2017 Idris SOP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
//#import "Weather.h"
#import "APIHelper.h"

@interface MyWeatherAppAPI : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property (strong, nonatomic) NSURLSessionConfiguration *sessionConfig;
@property (atomic, strong) dispatch_queue_t requestQueue;
+ (MyWeatherAppAPI*)sharedMyWeatherAppAPI;


- (void)getWeatherInfoFromServer:(BOOL)server WithParams:(NSMutableDictionary *)params withCompletion:(void (^) (BOOL success, NSObject *currentWeatherInfo, NSString *message))completion;

@end
