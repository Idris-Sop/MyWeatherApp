//
//  APIHelper.h
//  MyWeatherApp
//
//  Created by Idris SOP on 2017/05/18.
//  Copyright © 2017 Idris SOP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface APIHelper : NSObject
+ (NSURL *)apiURLWithExtension: (NSString *)extension;
@end
