//
//  ViewController.h
//  Todo+
//
//  Created by Grace on 6/11/13.
//  Copyright (c) 2013 Grace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "cocos2d.h"

@interface MapViewController : UIViewController <CCDirectorDelegate>
{
    UIWindow *window_;
	UINavigationController *navController_;
}

@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
- (MKMapRect)makeMapRectWithAnnotations:(NSArray *)annotations;

@property (strong, nonatomic) UIWindow *window;
@property (readonly) UINavigationController *navController;
@property (unsafe_unretained, readonly) CCDirectorIOS *director;

@end

