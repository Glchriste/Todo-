//
//  EndAnnotation.m
//  Ride
//
//  Created by Nic Hubbard on 6/22/10.
//  Copyright 2010 Zed Said Studio. All rights reserved.
//

#import "Annotation.h"

@implementation Annotation

- (id)initWithCoordinate:(CLLocationCoordinate2D)coord {
    self.coordinate = coord;
	return nil;
}

@end