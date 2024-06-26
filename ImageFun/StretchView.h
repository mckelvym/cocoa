//
//  StretchView.h
//  ImageFun
//
//  Created by mark mckelvy on 4/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface StretchView : NSView {
	NSBezierPath * bezierPath;
	NSImage * image;
	float opacity;
	NSPoint downPoint;
	NSPoint currentPoint;
}
@property (readwrite) float opacity;

- (void)setImage:(NSImage *)newImage;
- (NSPoint)randomPoint;
- (NSRect)currentRect;

@end
