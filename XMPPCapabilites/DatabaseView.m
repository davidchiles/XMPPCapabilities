//
//  DatabaseView.m
//  XMPPCapabilites
//
//  Created by David Chiles on 11/18/14.
//  Copyright (c) 2014 David Chiles. All rights reserved.
//

#import "DatabaseView.h"
#import "YapDatabaseView.h"
#import "XMPPServer.h"
#import "XMPPCapability.h"
#import "YapDatabase.h"

NSString *const kDatabaseViewGroupAll = @"kDatabaseViewGroupAll";
NSString *const kDatabaseViewXMPPServer = @"kDatabaseViewXMPPServer";
NSString *const kDatabaseviewXMPPCapabilities = @"kDatabaseviewXMPPCapabilities";

@implementation DatabaseView

+ (BOOL)setupViewsForDatabase:(YapDatabase *)database
{
    BOOL result = YES;
    if (result) result = [self setupServerViewForDatabase:database];
    if (result) result = [self setupCapabilitiesViewForDatabase:database];
    
    return result;
}

+ (BOOL)setupCapabilitiesViewForDatabase:(YapDatabase *)database
{
    if ([database registeredExtension:kDatabaseviewXMPPCapabilities]) {
        return YES;
    }
    
    YapDatabaseViewGrouping *grouping = [YapDatabaseViewGrouping withObjectBlock:^NSString *(NSString *collection, NSString *key, id object) {
        if ([object isKindOfClass:[XMPPCapability class]]) {
            return ((XMPPCapability *)object).serverDomain;
        }
        return nil;
    }];
    
    YapDatabaseViewSorting *sorting = [YapDatabaseViewSorting withObjectBlock:^NSComparisonResult(NSString *group, NSString *collection1, NSString *key1, id object1, NSString *collection2, NSString *key2, id object2) {
        
        if ([object1 isKindOfClass:[XMPPCapability class]] && [object2 isKindOfClass:[XMPPCapability class]]) {
            XMPPCapability *capability1 = (XMPPCapability *)object1;
            XMPPCapability *capability2 = (XMPPCapability *)object2;
            
            return [capability1.featureName compare:capability2.featureName options:NSCaseInsensitiveSearch];
            
        }
        return NSOrderedSame;
    }];
    
    YapDatabaseView *view = [[YapDatabaseView alloc] initWithGrouping:grouping sorting:sorting];
    return [database registerExtension:view withName:kDatabaseviewXMPPCapabilities];
}

+ (BOOL)setupServerViewForDatabase:(YapDatabase *)database
{
    if ([database registeredExtension:kDatabaseViewXMPPServer]) {
        return YES;
    }
    
    YapDatabaseViewGrouping *grouping = [YapDatabaseViewGrouping withKeyBlock:^NSString *(NSString *collection, NSString *key) {
        if ([collection isEqualToString:[XMPPServer collection]]) {
            return kDatabaseViewGroupAll;
        }
        return nil;
    }];
    
    YapDatabaseViewSorting *sorting = [YapDatabaseViewSorting withObjectBlock:^NSComparisonResult(NSString *group, NSString *collection1, NSString *key1, id object1, NSString *collection2, NSString *key2, id object2) {
        
        if ([object1 isKindOfClass:[XMPPServer class]] && [object2 isKindOfClass:[XMPPServer class]]) {
            XMPPServer *server1 = (XMPPServer *)object1;
            XMPPServer *server2 = (XMPPServer *)object2;
            
            return [server1.uniqueId compare:server2.uniqueId options:NSCaseInsensitiveSearch];
            
        }
        return NSOrderedSame;
    }];
    
    YapDatabaseView *view = [[YapDatabaseView alloc] initWithGrouping:grouping sorting:sorting];
    return [database registerExtension:view withName:kDatabaseViewXMPPServer];
}

@end
