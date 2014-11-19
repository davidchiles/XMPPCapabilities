//
//  XMPPCapabilitiesStorage.m
//  XMPPCapabilites
//
//  Created by David Chiles on 11/18/14.
//  Copyright (c) 2014 David Chiles. All rights reserved.
//

#import "CapabilitiesStorage.h"
#import "YapDatabase.h"
#import "AppDelegate.h"
#import "DatabaseManager.h"
#import "XMPPServer.h"
#import "XMPPCapability.h"

@interface CapabilitiesStorage ()

@property (nonatomic, strong) YapDatabaseConnection *databaseConnection;

@end

@implementation CapabilitiesStorage

- (YapDatabaseConnection *)databaseConnection
{
    if (!_databaseConnection) {
        _databaseConnection = [[AppDelegate sharedInstance].databaseManager newConnection];
        _databaseConnection.name = NSStringFromClass([self class]);
    }
    return _databaseConnection;
}

#pragma - mark XMPPStorageCapabilitesProtocol Methods

//
//
// -- PUBLIC METHODS --
//
//

/**
 * Returns whether or not we know the capabilities for a given jid.
 *
 * The stream parameter is optional.
 * If given, the jid must have been registered via the given stream.
 * Otherwise it will match the given jid from any stream this storage instance is managing.
 **/
- (BOOL)areCapabilitiesKnownForJID:(XMPPJID *)jid xmppStream:(XMPPStream *)stream
{
    
    return NO;
}

/**
 * Returns the capabilities for the given jid.
 * The returned element is the <query/> element response to a disco#info request.
 *
 * The stream parameter is optional.
 * If given, the jid must have been registered via the given stream.
 * Otherwise it will match the given jid from any stream this storage instance is managing.
 **/
- (NSXMLElement *)capabilitiesForJID:(XMPPJID *)jid xmppStream:(XMPPStream *)stream
{
    
    return nil;
}

/**
 * Returns the capabilities for the given jid.
 * The returned element is the <query/> element response to a disco#info request.
 *
 * The given jid should be a full jid (user@domain/resource) or a domin JID (domain without user or resource).
 *
 * If the jid has broadcast capabilities via the legacy format of XEP-0115,
 * the extension list may optionally be retrieved via the ext parameter.
 *
 * For example, the jid may send a presence element like:
 *
 * <presence from="jid">
 *   <c node="imclient.com/caps" ver="1.2" ext="rdserver rdclient avcap"/>
 * </presence>
 *
 * In the above example, the ext string would be set to "rdserver rdclient avcap".
 *
 * You may pass nil for extPtr if you don't care about the legacy attributes,
 * or you could simply use the capabilitiesForJID: method above.
 *
 * The stream parameter is optional.
 * If given, the jid must have been registered via the given stream.
 * Otherwise it will match the given jid from any stream this storage instance is managing.
 **/
- (NSXMLElement *)capabilitiesForJID:(XMPPJID *)jid ext:(NSString **)extPtr xmppStream:(XMPPStream *)stream
{
    
    return nil;
}

//
//
// -- PRIVATE METHODS --
//
// These methods are designed to be used ONLY by the XMPPCapabilities class.
//
//

/**
 * Configures the capabilities storage class, passing it's parent and parent's dispatch queue.
 *
 * This method is called by the init methods of the XMPPCapabilities class.
 * This method is designed to inform the storage class of it's parent
 * and of the dispatch queue the parent will be operating on.
 *
 * A storage class may choose to operate on the same queue as it's parent,
 * as the majority of the time it will be getting called by the parent.
 * If both are operating on the same queue, the combination may run faster.
 *
 * Some storage classes support multiple xmppStreams,
 * and may choose to operate on their own internal queue.
 *
 * This method should return YES if it was configured properly.
 * It should return NO only if configuration failed.
 * For example, a storage class designed to be used only with a single xmppStream is being added to a second stream.
 * The XMPPCapabilites class is configured to ignore the passed
 * storage class in it's init method if this method returns NO.
 **/
- (BOOL)configureWithParent:(XMPPCapabilities *)aParent queue:(dispatch_queue_t)queue
{
    
    return YES;
}

/**
 * Sets metadata for the given jid.
 *
 * This method should return:
 * - YES if the capabilities for the given jid are known.
 * - NO if the capabilities for the given jid are NOT known.
 *
 * If the hash and algorithm are given, and an associated set of capabilities matches the hash/algorithm,
 * this method should link the jid to the capabilities and return YES.
 *
 * If the linked set of capabilities was not previously linked to the jid,
 * the newCapabilities parameter shoud be filled out.
 *
 * This method may be called multiple times for a given jid with the same information.
 * If this method sets the newCapabilitiesPtr parameter,
 * the XMPPCapabilities module will invoke the xmppCapabilities:didDiscoverCapabilities:forJID: delegate method.
 * This delegate method is designed to be invoked only when the capabilities for the given JID have changed.
 * That is, the capabilities for the jid have been discovered for the first time (jid just signed in)
 * or the capabilities for the given jid have changed (jid broadcast new capabilities).
 **/
- (BOOL)setCapabilitiesNode:(NSString *)node
                        ver:(NSString *)ver
                        ext:(NSString *)ext
                       hash:(NSString *)hash
                  algorithm:(NSString *)hashAlg
                     forJID:(XMPPJID *)jid
                 xmppStream:(XMPPStream *)stream
      andGetNewCapabilities:(NSXMLElement **)newCapabilitiesPtr
{
    
    return YES;
}

/**
 * Fetches the associated capabilities hash for a given jid.
 *
 * If the jid is not associated with a capabilities hash, this method should return NO.
 * Otherwise it should return YES, and set the corresponding variables.
 **/
- (BOOL)getCapabilitiesHash:(NSString **)hashPtr
                  algorithm:(NSString **)hashAlgPtr
                     forJID:(XMPPJID *)jid
                 xmppStream:(XMPPStream *)stream
{
    
    return NO;
}

/**
 * Clears any associated hash from a jid.
 * If the jid is linked to a set of capabilities, it should be unlinked.
 *
 * This method should not clear the actual capabilities information itself.
 * It should simply unlink the connection between the jid and the capabilities.
 **/
- (void)clearCapabilitiesHashAndAlgorithmForJID:(XMPPJID *)jid xmppStream:(XMPPStream *)stream
{
    
}

/**
 * Gets the metadata for the given jid.
 *
 * If the capabilities are known, the areCapabilitiesKnown boolean should be set to YES.
 **/
- (void)getCapabilitiesKnown:(BOOL *)areCapabilitiesKnownPtr
                      failed:(BOOL *)haveFailedFetchingBeforePtr
                        node:(NSString **)nodePtr
                         ver:(NSString **)verPtr
                         ext:(NSString **)extPtr
                        hash:(NSString **)hashPtr
                   algorithm:(NSString **)hashAlgPtr
                      forJID:(XMPPJID *)jid
                  xmppStream:(XMPPStream *)stream
{
    *areCapabilitiesKnownPtr = NO;
    *haveFailedFetchingBeforePtr = NO;
}

/**
 * Sets the capabilities associated with a given hash.
 *
 * Since the capabilities are linked to a hash, these capabilities (and associated hash)
 * should be persisted to disk and persisted between multiple sessions/streams.
 *
 * It is the responsibility of the storage implementation to link the
 * associated jids (those with the given hash) to the given set of capabilities.
 *
 * Implementation Note:
 *
 * If we receive multiple simultaneous presence elements from
 * multiple jids all broadcasting the same capabilities hash:
 *
 * - A single disco request will be sent to one of the jids.
 * - When the response comes back, the setCapabilities:forHash:algorithm: method will be invoked.
 *
 * The setCapabilities:forJID: method will NOT be invoked for each corresponding jid.
 * This is by design to allow the storage implementation to optimize itself.
 **/
- (void)setCapabilities:(NSXMLElement *)caps forHash:(NSString *)hash algorithm:(NSString *)hashAlg
{
    
}

/**
 * Sets the capabilities for a given jid.
 *
 * The jid is guaranteed NOT to be associated with a capabilities hash.
 *
 * Since the capabilities are NOT linked to a hash,
 * these capabilities should not be persisted between multiple sessions/streams.
 * See the various clear methods below.
 **/
- (void)setCapabilities:(NSXMLElement *)caps forJID:(XMPPJID *)jid xmppStream:(XMPPStream *)stream
{
    [self.databaseConnection readWriteWithBlock:^(YapDatabaseReadWriteTransaction *transaction) {
        
        XMPPServer *server = [XMPPServer fetchObjectWithUniqueID:jid.domain transaction:transaction];
        if (!server) {
            server = [[XMPPServer alloc] initWithUniqueId:jid.domain];
            [server saveWithTransaction:transaction];
        }
        
        NSArray *features = [caps elementsForName:@"feature"];
        [features enumerateObjectsUsingBlock:^(DDXMLElement *element, NSUInteger idx, BOOL *stop) {
            NSString *var = [element attributeStringValueForName:@"var"];
            if ([var length]) {
                
                XMPPCapability *capability = [[XMPPCapability alloc] initWithUniqueId:[NSString stringWithFormat:@"%@-%@",server.uniqueId,var]];
                capability.serverDomain = server.uniqueId;
                capability.featureName = var;
                [capability saveWithTransaction:transaction];
            }
        }];
        
        
        
    }];
}

/**
 * Marks the disco fetch request as failed so we know not to bother trying again.
 *
 * This is temporary metadata associated with the jid.
 * It should be cleared when we go unavailable or offline, or if the given jid goes unavailable.
 * See the various clear methods below.
 **/
- (void)setCapabilitiesFetchFailedForJID:(XMPPJID *)jid xmppStream:(XMPPStream *)stream
{
    
}

/**
 * This method is called when we go unavailable or offline.
 *
 * This method should clear all metadata (node, ver, ext, hash, algorithm, failed) from all jids in the roster.
 * All jids should be unlinked from associated capabilities.
 *
 * If the associated capabilities are persistent, they should not be cleared.
 * That is, if the associated capabilities are associated with a hash, they should be persisted.
 *
 * Non persistent capabilities (those not associated with a hash)
 * should be cleared at this point as they will no longer be linked to any users.
 **/
- (void)clearAllNonPersistentCapabilitiesForXMPPStream:(XMPPStream *)stream
{
    
}

/**
 * This method is called when the given jid goes unavailable.
 *
 * This method should clear all metadata (node, ver, ext, hash ,algorithm, failed) from the given jid.
 * The jid should be unlinked from associated capabilities.
 *
 * If the associated capabilities are persistent, they should not be cleared.
 * That is, if the associated capabilities are associated with a hash, they should be persisted.
 *
 * Non persistent capabilities (those not associated with a hash) should be cleared.
 **/
- (void)clearNonPersistentCapabilitiesForJID:(XMPPJID *)jid xmppStream:(XMPPStream *)stream
{
  
}

@end
