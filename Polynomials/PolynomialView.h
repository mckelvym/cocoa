//
//  PolynomialView.h
//  Polynomials
//
//  Created by mark mckelvy on 5/31/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface PolynomialView : NSView {
	NSMutableArray * polynomials;
	BOOL blasted;
}

- (IBAction)createNewPolynomials:(id)sender;
- (IBAction)deleteRandomPolynomial:(id)sender;
- (IBAction)blast:(id)sender;
- (NSPoint)randomOffViewPosition;

@end
