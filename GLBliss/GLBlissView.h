//
//  GLBlissView.h
//  GLBliss
//
//  Created by mark mckelvy on 5/31/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface GLBlissView : NSOpenGLView {
	IBOutlet NSMatrix * sliderMatrix;
	float lightX;
	float theta;
	float radius;
	int displayList;
}

- (IBAction)changeParameter:(id)sender;

@end
