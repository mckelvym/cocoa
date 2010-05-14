#import <Foundation/Foundation.h>
#import "Forwarder.h"
#import "Recipient.h"

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

    // insert code here...
    NSLog(@"Hello, World!");
	
	Forwarder *forwarder = [Forwarder new];
    Recipient *recipient = [Recipient new];
	
    [forwarder setRecipient:recipient]; //Set the recipient. 
    /* 
     * Observe forwarder does not respond to a hello message! It will
     * be forwarded. All unrecognized methods will be forwarded to
     * the recipient 
     * (if the recipient responds to them, as written in the Forwarder)
     */
    [forwarder hello]; 	
	
	
    [pool drain];
    return 0;
}
