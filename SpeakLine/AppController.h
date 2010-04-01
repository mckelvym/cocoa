//
//  AppController.h
//  SpeakLine
//
//  Created by mark mckelvy on 3/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface AppController : NSObject {
	IBOutlet NSTextField * textField;
	IBOutlet NSButton * stopButton;
	IBOutlet NSButton * speakButton;
	NSSpeechSynthesizer * speechSynth;
}

- (IBAction)sayIt:(id)sender;
- (IBAction)stopIt:(id)sender;
- (void)curseIt:(id)sender;

@end
