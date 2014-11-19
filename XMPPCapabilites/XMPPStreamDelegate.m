//
//  XMPPStreamDelegate.m
//  XMPPCapabilites
//
//  Created by David Chiles on 11/18/14.
//  Copyright (c) 2014 David Chiles. All rights reserved.
//

#import "XMPPStreamDelegate.h"
#import "XMPPFramework.h"
#import "XMPPStreamManagement.h"

@implementation XMPPStreamDelegate

- (void)xmppStreamDidConnect:(XMPPStream *)sender
{
    [sender authenticateWithPassword:self.password error:nil];
}

- (void)xmppStream:(XMPPStream *)sender willSecureWithSettings:(NSMutableDictionary *)settings
{
    settings[GCDAsyncSocketManuallyEvaluateTrust] = @(YES);
}

- (void)xmppStream:(XMPPStream *)sender didReceiveTrust:(SecTrustRef)trust completionHandler:(void (^)(BOOL))completionHandler
{
    if (completionHandler) {
        completionHandler(YES);
    }
}
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    
}

- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error
{
    
}

- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error
{
    
}

@end
