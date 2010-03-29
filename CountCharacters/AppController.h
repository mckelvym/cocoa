//
//  AppController.h
//  CountCharacters
//
//  Created by mark mckelvy on 3/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface AppController : NSObject {
	IBOutlet NSTextField * textField;	
	IBOutlet NSTextField * label;
}

- (IBAction)countChars:(id)sender;

@end
