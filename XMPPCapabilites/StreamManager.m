//
//  StreamManager.m
//  XMPPCapabilites
//
//  Created by David Chiles on 11/18/14.
//  Copyright (c) 2014 David Chiles. All rights reserved.
//

#import "StreamManager.h"
#import "XMPPFramework.h"
#import "XMPPStreamDelegate.h"
#import "CapabilitiesStorage.h"
#import "XMPPMUC.h"

@interface StreamManager ()

@property (nonatomic, strong) XMPPStream *xmppStream;
@property (nonatomic, strong) XMPPStreamDelegate *xmppStreamDelegate;
@property (nonatomic, strong) XMPPCapabilities *xmppCapabilities;
@property (nonatomic, strong) CapabilitiesStorage *capabilitiesStorage;

@end

@implementation StreamManager

- (instancetype)init
{
    if (self = [super init]) {
        self.xmppStream = [[XMPPStream alloc] init];
        self.xmppStreamDelegate = [[XMPPStreamDelegate alloc] init];
        self.capabilitiesStorage = [[CapabilitiesStorage alloc] init];
        self.xmppCapabilities = [[XMPPCapabilities alloc] initWithCapabilitiesStorage:self.capabilitiesStorage];
        self.xmppCapabilities.autoFetchMyServerCapabilities = YES;
        self.xmppCapabilities.autoFetchNonHashedCapabilities = YES;
        
        XMPPMUC *muc = [[XMPPMUC alloc] init];
        [muc activate:self.xmppStream];
        
        [self.xmppCapabilities activate:self.xmppStream];
        [self.xmppStreamDelegate activate:self.xmppStream];
    }
    return self;
}

- (void)connectWithJID:(NSString *)JID password:(NSString *)password
{
    NSAssert([JID length] > 0, @"JID has to have length");
    NSAssert([password length] > 0, @"passwod has to have length");
    
    
    self.xmppStream.myJID = [XMPPJID jidWithString:JID];
    self.xmppStreamDelegate.password = password;
    
    [self.xmppStream connectWithTimeout:10 error:nil];
}

@end
