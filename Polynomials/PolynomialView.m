//
//  PolynomialView.m
//  Polynomials
//
//  Created by mark mckelvy on 5/31/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PolynomialView.h"
#import "Polynomial.h"
#import <QuartzCore/QuartzCore.h>

#define MARGIN (10)

@implementation PolynomialView

- (id)initWithFrame:(NSRect)frame
{
	[super initWithFrame:frame];
	polynomials = [[NSMutableArray alloc] init];
	blasted = NO;
	return self;
}

- (IBAction)createNewPolynomials:(id)sender
{
	Polynomial * p = [[Polynomial alloc] init];
	[polynomials addObject:p];
	
	// Create a layer
	CALayer * layer = [CALayer layer];
	CGRect b = [[self layer] bounds];
	b = CGRectInset(b, MARGIN, MARGIN);
	[layer setAnchorPoint:CGPointMake(0, 0)];
	[layer setFrame:b];
	[layer setCornerRadius:12];
	[layer setBorderColor:[p color]];
	[layer setBorderWidth:3.5];
	
	// The instance of Polynomials will do the drawing
	[layer setDelegate:p];
	
	// Add the new layer to the base layer for hte view
	[[self layer] addSublayer:layer];
	
	// Render the layer
	[layer display];
	
	// Make an animation that will move the layer on screen in 1 second
	CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position"];
	[animation setFromValue:[NSValue valueWithPoint:[self randomOffViewPosition]]];
	[animation setToValue:[NSValue valueWithPoint:NSMakePoint(MARGIN, MARGIN)]];
	[animation setDuration:1.0];
	
	CAMediaTimingFunction * func = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	[animation setTimingFunction:func];
	
	// Start the animation
	[layer addAnimation:animation forKey:@"whatever"];
	
	//[self setNeedsDisplay:YES];
}

- (IBAction)deleteRandomPolynomial:(id)sender
{
	// Get the array of CALayers that represent polynomials
	NSArray * polynomialLayers = [[self layer] sublayers];
	
	// Are there no polynomials to remove?
	if ([polynomialLayers count] == 0)
	{
		NSBeep();
		return;
	}
	
	// Pick a random layer
	int i = random() % [polynomialLayers count];
	CALayer * layerToPull = [polynomialLayers objectAtIndex:i];
	
	// Choose a point to drag it off to
	NSPoint randomPoint = [self randomOffViewPosition];
	
	// Create the animation that will drive the motion offscreen
	CABasicAnimation * anim = [CABasicAnimation animationWithKeyPath:@"position"];
	
	// The animation will let you stuff anything that you want into its
	// dictionary. At the end of the animation, you will want to know which
	// polynomial was dragged off the screen.
	
	NSLog(@"anim setValue:");
	[anim setValue:layerToPull forKey:@"representedPolynomialLayer"];
	NSLog(@"after anim setValue:");
	[anim setFromValue:[NSValue valueWithPoint:NSMakePoint(MARGIN, MARGIN)]];
	[anim setToValue:[NSValue valueWithPoint:randomPoint]];
	[anim setDuration:1.0];
	CAMediaTimingFunction * func = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	[anim setTimingFunction:func];
	
	// You need a callback when the animation is done
	[anim setDelegate:self];
	[layerToPull addAnimation:anim forKey:@"whatever"];
	
	// The position during the animation is temporary. Without the next
	// line, the deleted polynomial flashes before being removed.
	[layerToPull setPosition:CGPointMake(randomPoint.x, randomPoint.y)];
	
	/*
	if ([polynomials count] == 0)
	{
		NSBeep();
		return;
	}
	
	int i = random() % [polynomials count];
	[polynomials removeObjectAtIndex:i];
	[self setNeedsDisplay:YES];
	 */
}

- (void)drawRect:(NSRect)rect 
{
	NSRect bounds = [self bounds];
	[[NSColor whiteColor] set];
	[NSBezierPath fillRect:bounds];
	
	/*
	// Get a hold of the core graphics context
	CGContextRef ctx = [[NSGraphicsContext currentContext] graphicsPort];
	CGRect cgBounds = *(CGRect *)&bounds;
	// Draw the polynomials
	for (Polynomial * p in polynomials)
	{
		[p drawInRect:cgBounds inContext:ctx];
	}
	 */
}

- (IBAction)blast:(id)sender
{
	[NSAnimationContext beginGrouping];
	[[NSAnimationContext currentContext] setDuration:3.0];
	NSArray * polynomialLayers = [[self layer] sublayers];
	
	for (CALayer * layer in polynomialLayers)
	{
		CGPoint p;
		if (blasted)
		{
			p = CGPointMake(MARGIN, MARGIN);
		}
		else
		{
			NSPoint r = [self randomOffViewPosition];
			// Convert NSPoint to CGPoint
			p = *(CGPoint *)&r;
		}
		[layer setPosition:p];
	}
	[NSAnimationContext endGrouping];
	blasted = !blasted;
}

- (NSPoint)randomOffViewPosition
{
	NSRect bounds = [self bounds];
	float radius = hypot(bounds.size.width, bounds.size.height);
	float angle = 2.0 * M_PI * (random() % 360 / 360.0);
	NSPoint p;
	p.x = radius * cos(angle);
	p.y = radius * sin(angle);
	return p;
}

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag
{
	CALayer * layerToPull = [animation valueForKey:@"representedPolynomialLayer"];
	Polynomial * p = [layerToPull delegate];
	[polynomials removeObjectIdenticalTo:p];
	[layerToPull removeFromSuperlayer];
}

- (void)resizeAndRedrawPolynomialLayers
{
	CGRect b = [[self layer] bounds];
	b = CGRectInset(b, MARGIN, MARGIN);
	
	NSArray * polynomialLayers = [[self layer] sublayers];
	[NSAnimationContext beginGrouping];
	[[NSAnimationContext currentContext] setDuration:0];
	
	for (CALayer * layer in polynomialLayers)
	{
		b.origin = [layer frame].origin;
		[layer setFrame:b];
		[layer setNeedsDisplay];
	}
	
	[NSAnimationContext endGrouping];
}

- (void)setFrameSize:(NSSize)newSize
{
	[super setFrameSize:newSize];
	if (![self inLiveResize])
	{
		[self resizeAndRedrawPolynomialLayers];
	}
}

- (void)viewDidEndLiveResize
{
	[self resizeAndRedrawPolynomialLayers];
}


@end
