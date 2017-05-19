//
//  APIHelper.m
//  MyWeatherApp
//
//  Created by Idris SOP on 2017/05/18.
//  Copyright © 2017 Idris SOP. All rights reserved.
//

#import "APIHelper.h"


@implementation APIHelper

+ (NSURL *)apiURLWithExtension:(NSString *)extension {
    NSString *baseURL = BASEURL;
    return [NSURL URLWithString:[baseURL stringByAppendingString:extension]];
}

@end
