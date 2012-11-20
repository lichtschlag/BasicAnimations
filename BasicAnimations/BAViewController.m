//
//  BAViewController.m
//  BasicAnimations
//
//  Created by Leonhard Lichtschlag on 29/Nov/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BAViewController.h"
#import <QuartzCore/CoreAnimation.h>

@implementation BAViewController

@synthesize doItButton;
@synthesize carLayer;
@synthesize carLayer2;

#pragma mark - View lifecycle

- (void) viewDidLoad
{
    [super viewDidLoad];
	
	// Do any additional setup after loading the view, typically from a nib.
	self.carLayer = [CALayer layer];

	UIImage* carImage = [UIImage imageNamed:@"car"];
	carLayer.contents = (id)carImage.CGImage;
	
	carLayer.position = CGPointMake(100, 75);
	carLayer.bounds = CGRectMake(0, 0, 75, 150);
	//carLayer.backgroundColor = [[UIColor colorWithWhite:0.702 alpha:1.000] CGColor];
	
	[self.view.layer addSublayer:carLayer];
	
	
	// second
	self.carLayer2 = [CALayer layer];
	
	carLayer2.contents = (id)carImage.CGImage;
	
	carLayer2.position = CGPointMake(200, 75);
	carLayer2.bounds = CGRectMake(0, 0, 75, 150);

	[self.view.layer addSublayer:carLayer2];
}

- (void) viewDidUnload
{
    [self setDoItButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void) viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


#pragma mark - Interaction

- (IBAction) doIt:(id)sender 
{
	// stage 1
	carLayer.position = CGPointMake(100, 300);
	
	// stage 2
	//	CGPoint orgPoint		= carLayer2.position;
	//	CGPoint targetPoint		= CGPointMake(orgPoint.x, orgPoint.y + 200.0);
//	
//	CABasicAnimation *move = [[CABasicAnimation alloc] init];
//	move.keyPath = @"position";
//	move.fromValue = [NSValue valueWithCGPoint:orgPoint];
//	move.toValue = [NSValue valueWithCGPoint:targetPoint];
//	move.duration = 3.0;
//	move.autoreverses = YES;
//	move.repeatCount = 1000;
//	
//	carLayer2.position = targetPoint;
//	[carLayer2 addAnimation:move forKey:@"moveAnimation"];
	
	
	// path magic
	CGMutablePathRef path = CGPathCreateMutable();
	CGPoint point = carLayer2.position;
	CGPathMoveToPoint(path, NULL, point.x, point.y);
	point = CGPointMake((CGFloat)point.x, point.y+100);
	CGPathAddLineToPoint(path, NULL, point.x, point.y);
	point = CGPointMake((CGFloat)point.x+50, point.y+50);
	CGPathAddLineToPoint(path, NULL, point.x, point.y);
	point = CGPointMake((CGFloat)point.x, point.y);
	CGPathAddLineToPoint(path, NULL, point.x+50, point.y);
	point = CGPointMake((CGFloat)point.x, point.y);
	CGPathAddLineToPoint(path, NULL, point.x, point.y+150);
	CGPathCloseSubpath(path);
	
	// stage 3	
	[CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
	carLayer2.transform = CATransform3DMakeRotation(-90.0 / 180.0 * M_PI, 0.0, 0.0, 1.0);
	[CATransaction commit];
	
	CAKeyframeAnimation *move2 = [[CAKeyframeAnimation alloc] init];
	move2.keyPath = @"position";
	move2.duration = 10.0;
	//`	move2.autoreverses = YES;
	//	move2.repeatCount = 1000;
	move2.path = path;
	move2.rotationMode = kCAAnimationRotateAuto;
	
	[carLayer2 addAnimation:move2 forKey:@"moveAnimation"];	
}


@end

