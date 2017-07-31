//
//  MyWeatherAppAPI.m
//  MyWeatherApp
//
//  Created by Idris SOP on 2017/05/18.
//  Copyright © 2017 Idris SOP. All rights reserved.
//

#import "MyWeatherAppAPI.h"

@implementation MyWeatherAppAPI

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize sessionConfig;
@synthesize persistentContainer = _persistentContainer;


+ (MyWeatherAppAPI*)sharedMyWeatherAppAPI {
    static MyWeatherAppAPI *sharedMyWeatherAppAPI;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyWeatherAppAPI = [[MyWeatherAppAPI alloc] init];
    });
    return sharedMyWeatherAppAPI;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupNSURLConfig];
        self.requestQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    }
    return self;
}

- (void)setupNSURLConfig {
    self.sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.sessionConfig.allowsCellularAccess = YES;
    self.sessionConfig.timeoutIntervalForRequest = 60.0;
    self.sessionConfig.HTTPMaximumConnectionsPerHost = 5;
}


#pragma mark - Core Data stack

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"MyWeatherApp"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

- (void)getWeatherInfoFromServer:(BOOL)server WithParams:(NSMutableDictionary *)params withCompletion:(void (^)(BOOL, NSObject *, NSString *))completion {
    if (server) {
        NSURLSession *session = [NSURLSession sessionWithConfiguration:self.sessionConfig];
        NSMutableURLRequest *requestURL = [NSMutableURLRequest requestWithURL: [APIHelper apiURLWithExtension:[self buildFormParameters:params]]];
        requestURL.HTTPMethod = @"GET";
        [requestURL setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
        
        NSLog(@"requestURL: %@", requestURL);
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:requestURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (!error) {
                
                NSHTTPURLResponse *resp = (NSHTTPURLResponse *)response;
                if (resp.statusCode == 200) {
                    [self deleteRecordFromEntity:@"Weather"];
                    NSObject *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    NSLog(@"JSON Response: %@", json);
                    completion(YES, json, nil);
                } else {
                    NSString *responseBody = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    completion(NO, nil, responseBody);
                }
            } else {
                NSString *responseBody = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                completion(NO, nil, responseBody);
            }
        }];
        [dataTask resume];
    }
}

- (void)deleteRecordFromEntity:(NSString *)entity {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSError *error;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entity];
    NSArray *fetchedRecords = [context executeFetchRequest:request error:&error];
    if ([fetchedRecords count] != 0) {
        for (NSManagedObject *object in fetchedRecords) {
            [context deleteObject:object];
        }
        [context save:&error];
    }
}

- (NSString *)buildFormParameters:(NSDictionary *)parameters {
    NSString * responseString = @"";
    BOOL shouldAddAnd = NO;
    for (NSString *key in parameters) {
        if (shouldAddAnd) {
            responseString = [NSString stringWithFormat:@"%@&", responseString];
        }
        responseString = [NSString stringWithFormat:@"%@%@=%@", responseString, key, [parameters valueForKey:key]];
        
        shouldAddAnd = YES;
    }
    return responseString;
}

@end
