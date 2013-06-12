//
//  MapSingleton.h
//  Todo+
//
//  Created by Grace on 6/12/13.
//  Copyright (c) 2013 Grace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "cocos2d.h"
#import "LineDrawer.h"
#import "CCNode+SFGestureRecognizers.h"

@interface MapSingleton : NSObject

+ (MapSingleton *) mapSingleton;

@property(nonatomic) CGPoint markerPoint;

-(void)setMarkerPoint;
-(CGPoint)getMarkerPoint;

@end
