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
}
@property (readwrite) float opacity;

- (void)setImage:(NSImage *)newImage;
- (NSPoint)randomPoint;

@end
