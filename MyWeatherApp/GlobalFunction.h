//
//  GlobalFunction.h
//  MyWeatherApp
//
//  Created by Idris SOP on 2017/05/18.
//  Copyright © 2017 Idris SOP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#ifndef GlobalFunction_h
#define GlobalFunction_h


static inline UIColor *appHighlightColor() {
    return [UIColor colorWithRed:241.0F / 255.0F green:90.0F / 255.0F blue:35.0F / 255.0F alpha:1.0];
}

static inline UIColor *tabBarSelectedItemTintColor() {
    return [UIColor colorWithRed:256/255.0 green:136/255.0 blue:51/255.0 alpha:1.0];
}

static inline UIColor *appBackgroundColor() {
    return [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
}

static inline UIColor *buttonBackgroundColor() {
    return [UIColor colorWithRed:1/255.0 green:140/255.0 blue:203/255.0 alpha:1.0];
}

static inline UIColor *redColor() {
    return [UIColor colorWithRed:187/255.0 green:27/255.0 blue:55/255.0 alpha:1.0];
}

static inline UIColor *redDarkColor() {
    return [UIColor colorWithRed:146/255.0 green:22/255.0 blue:44/255.0 alpha:1.0];
}

#endif /* GlobalFunction_h */
