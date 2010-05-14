//
//  AppController.h
//  ImageFun
//
//  Created by mark mckelvy on 5/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class StretchView;

@interface AppController : NSObject {
	IBOutlet StretchView * stretchView;
}

- (IBAction)showOpenPanel:(id)sender;

@end
