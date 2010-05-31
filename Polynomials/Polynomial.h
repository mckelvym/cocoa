//
//  Polynomial.h
//  Polynomials
//
//  Created by mark mckelvy on 5/31/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Polynomial : NSObject {
	__strong CGFloat * terms;
	int termCount;
	__strong CGColorRef color;
}

- (float)valueAt:(float)x;
- (void)drawInRect:(CGRect)b inContext:(CGContextRef)ctx;
- (CGColorRef)color;

@end
