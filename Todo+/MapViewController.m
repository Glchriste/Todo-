//
//  ViewController.m
//  Todo+
//
//  Created by Grace on 6/11/13.
//  Copyright (c) 2013 Grace. All rights reserved.
//

#import "MapViewController.h"
#import "ZSPinAnnotation.h"
#import "Annotation.h"
#import "LineDrawer.h"

#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

@interface MapViewController ()

@end

@implementation MapViewController
@synthesize searchBar;
@synthesize mapView;
@synthesize director;
@synthesize navController;
@synthesize window;

#pragma mark - View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}//end

- (IBAction)toggleMenu:(id)sender {
    //Toggle the search bar
    NSLog(@"Menu Toggle");
    if(searchBar.hidden == NO)
    {
        //Hide the search bar and disable default map interaction
        searchBar.hidden = YES;
        mapView.zoomEnabled = NO;
        mapView.scrollEnabled = NO;
        mapView.userInteractionEnabled = NO;
        [window addSubview:navController.view];
    }
    else {
        //Show the search bar and enable default map interaction
        searchBar.hidden = NO;
        mapView.zoomEnabled = YES;
        mapView.scrollEnabled = YES;
        mapView.userInteractionEnabled = YES;
        [navController.view removeFromSuperview];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Create the main window
    window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    // Create an CCGLView with a RGB565 color buffer, and a depth buffer of 0-bits
    CCGLView *glView = [CCGLView viewWithFrame:[window bounds]
                                   pixelFormat:kEAGLColorFormatRGBA8 //kEAGLColorFormatRGB565
                                   depthFormat:0	//GL_DEPTH_COMPONENT24_OES
                            preserveBackbuffer:NO
                                    sharegroup:nil
                                 multiSampling:NO
                               numberOfSamples:0];
    glView.opaque = NO;
    glView.backgroundColor = [UIColor clearColor];
    //glView.alpha = 0.5f;
    director = (CCDirectorIOS*) [CCDirector sharedDirector];
    
    //glClearColor(0.0, 0.0, 0.0, 0.0);
    //director_.wantsFullScreenLayout = YES;
    
    // Display FSP and SPF Option
    [director setDisplayStats:NO];
    
    // set FPS at 60
    [director setAnimationInterval:1.0/60];
    
    // attach the openglView to the director
    [director setView:glView];
    //director.view.backgroundColor = [UIColor clearColor];
    // for rotation and other messages
    [director setDelegate:self];
    
    // 2D projection
    [director setProjection:kCCDirectorProjection2D];
    //	[director setProjection:kCCDirectorProjection3D];
    
    // Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
    if( ! [director enableRetinaDisplay:YES] )
        CCLOG(@"Retina Display Not supported");
    
    // Create a Navigation Controller with the Director
    navController = [[UINavigationController alloc] initWithRootViewController:director];
    navController.navigationBarHidden = YES;
    
    //Add a tap gesture to the navigation controller (during drawing)
    // Create and initialize a tap gesture
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self action:@selector(toggleMenu:)];
    
    // Specify that the gesture must be a single tap
    tapRecognizer.numberOfTapsRequired = 1;
    
    // Add the tap gesture recognizer to the view
    [navController.view addGestureRecognizer:tapRecognizer];
    
    // set the Navigation Controller as the root view controller
    window = self.window;
    //[window setRootViewController:navController];
    [window setRootViewController:self];
    [window addSubview:self.view];
    //[window addSubview:navController.view];
    // make main window visible
    [window makeKeyAndVisible];
    
    // Default texture format for PNG/BMP/TIFF/JPEG/GIF images
    // It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
    // You can change anytime.
    [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
    
    // Assume that PVR images have premultiplied alpha
    [CCTexture2D PVRImagesHavePremultipliedAlpha:YES];
    
    // and add the scene to the stack. The director will run it when it automatically when the view is displayed.
    CCScene *scene = [CCScene node];
    [scene addChild:[LineDrawer node]];
    [director pushScene: scene];
    
    //self.view = director.view;

    //Map Code
	[mapView setShowsUserLocation:YES];
    // Array
	NSMutableArray *annotationArray = [[NSMutableArray alloc] init];
	
	// Create some annotations
	Annotation *annotation = nil;
	
	annotation = [[Annotation alloc] init];
	annotation.coordinate = CLLocationCoordinate2DMake(45.570, -122.695);
	annotation.color = RGB(13, 0, 182);
	annotation.title = @"Color Annotation";
	[annotationArray addObject:annotation];
	
	annotation = [[Annotation alloc] init];
	annotation.coordinate = CLLocationCoordinate2DMake(45.492, -122.798);
	annotation.color = RGB(0, 182, 146);
	annotation.title = @"Color Annotation";
	[annotationArray addObject:annotation];
	
	annotation = [[Annotation alloc] init];
	annotation.coordinate = CLLocationCoordinate2DMake(45.524, -122.704);
	annotation.color = RGB(182, 154, 0);
	annotation.title = @"Color Annotation";
	[annotationArray addObject:annotation];
	
	annotation = [[Annotation alloc] init];
	annotation.coordinate = CLLocationCoordinate2DMake(45.591, -122.617);
	annotation.color = RGB(88, 88, 88);
	annotation.title = @"Color Annotation";
	[annotationArray addObject:annotation];
	
	annotation = [[Annotation alloc] init];
	annotation.coordinate = CLLocationCoordinate2DMake(45.497, -122.634);
	annotation.color = [UIColor redColor];
	annotation.title = @"Color Annotation";
	[annotationArray addObject:annotation];
	
	annotation = [[Annotation alloc] init];
	annotation.coordinate = CLLocationCoordinate2DMake(45.553, -122.607);
	annotation.color = [UIColor purpleColor];
	annotation.title = @"Color Annotation";
	[annotationArray addObject:annotation];
	
	annotation = [[Annotation alloc] init];
	annotation.coordinate = CLLocationCoordinate2DMake(45.520, -122.618);
	annotation.color = [UIColor greenColor];
	annotation.title = @"Color Annotation";
	[annotationArray addObject:annotation];
	
	annotation = [[Annotation alloc] init];
	annotation.coordinate = CLLocationCoordinate2DMake(45.540, -122.618);
	annotation.color = [UIColor magentaColor];
	annotation.title = @"Color Annotation";
	[annotationArray addObject:annotation];
	
	// Center map
	self.mapView.visibleMapRect = [self makeMapRectWithAnnotations:annotationArray];
	
	// Add to map
	[self.mapView addAnnotations:annotationArray];

}


#pragma mark - MapKit

/**
 * Creates a MKMapRect with the provided annotations
 *
 * @version $Revision: 0.1
 */
- (MKMapRect)makeMapRectWithAnnotations:(NSArray *)annotations {
	
	MKMapRect flyTo = MKMapRectNull;
    for (id <MKAnnotation> annotation in annotations) {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
        if (MKMapRectIsNull(flyTo)) {
            flyTo = pointRect;
        } else {
            flyTo = MKMapRectUnion(flyTo, pointRect);
        }
    }
	
	return flyTo;
	
}//end


/**
 * Annotation Views
 *
 * @version $Revision: 0.1
 */
- (MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation {
	
	if(![annotation isKindOfClass:[Annotation class]]) // Don't mess user location
        return nil;
	
	static NSString *defaultPinID = @"StandardIdentifier";
	MKAnnotationView *pinView = (MKAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
	if (pinView == nil){
		pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:defaultPinID];
	}
	
	// Build our annotation
	if ([annotation isKindOfClass:[Annotation class]]) {
		Annotation *a = (Annotation *)annotation;
		pinView.image = [ZSPinAnnotation pinAnnotationWithColor:a.color];// ZSPinAnnotation Being Used
		pinView.annotation = a;
		pinView.enabled = YES;
        
        // Offset to correct placement
        pinView.centerOffset = CGPointMake(7, -15);
        pinView.calloutOffset = CGPointMake(-7, 0);
        
	}
	
	pinView.canShowCallout = YES;
	
	return pinView;
	
}//end


/**
 * Added Annotation Views
 *
 * @version $Revision: 0.1
 */
- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    
	MKAnnotationView *aV;
	
    for (aV in views) {
		
        // Don't pin drop if annotation is user location
        if ([aV.annotation isKindOfClass:[MKUserLocation class]]) {
            continue;
        }
		
        // Check if current annotation is inside visible map rect, else go to next one
        MKMapPoint point =  MKMapPointForCoordinate(aV.annotation.coordinate);
        if (!MKMapRectContainsPoint(self.mapView.visibleMapRect, point)) {
            continue;
        }
		
        CGRect endFrame = aV.frame;
		
        // Move annotation out of view
        aV.frame = CGRectMake(aV.frame.origin.x, aV.frame.origin.y - self.view.frame.size.height, aV.frame.size.width, aV.frame.size.height);
		
        // Animate drop
        [UIView animateWithDuration:0.5 delay:0.04*[views indexOfObject:aV] options:UIViewAnimationCurveLinear animations:^{
			
            aV.frame = endFrame;
			
			// Animate squash
        }completion:^(BOOL finished){
            if (finished) {
                [UIView animateWithDuration:0.05 animations:^{
                    aV.transform = CGAffineTransformMakeScale(1.0, 0.8);
					
                }completion:^(BOOL finished){
                    if (finished) {
                        [UIView animateWithDuration:0.1 animations:^{
                            aV.transform = CGAffineTransformIdentity;
                        }];
                    }
                }];
            }
        }];
    }
}//end

#pragma mark - Memory Management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [[CCDirector sharedDirector] setDelegate:nil];
}




@end
