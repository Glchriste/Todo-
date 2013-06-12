//
//  AppDelegate.h
//  Todo+
//
//  Created by Grace on 6/11/13.
//  Copyright (c) 2013 Grace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, CCDirectorDelegate>
{
    UIWindow *window_;
	UINavigationController *navController_;
}

@property (strong, nonatomic) UIWindow *window;
@property (readonly) UINavigationController *navController;
@property (unsafe_unretained, readonly) CCDirectorIOS *director;

@end
