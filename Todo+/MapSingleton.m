//
//  MapSingleton.m
//  Todo+
//
//  Created by Grace on 6/12/13.
//  Copyright (c) 2013 Grace. All rights reserved.
//

#import "MapSingleton.h"


@implementation MapSingleton
@synthesize markerPoint;

+ (MapSingleton *) mapSingleton
{
    static MapSingleton *mapSingleton;
    @synchronized(self)
    {
        if (!mapSingleton) {
            mapSingleton = [[MapSingleton alloc] init];
            CGPoint initialPoint;
            initialPoint.x = -1.0f;
            initialPoint.y = -1.0f;
            [mapSingleton setMarkerPoint:initialPoint];
        }
        
        return mapSingleton;
    }
}


-(void)setMarkerPoint:(CGPoint)point {
    markerPoint = point;
}

-(CGPoint)getMarkerPoint {
    return markerPoint;
}

@end