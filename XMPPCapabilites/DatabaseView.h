//
//  DatabaseView.h
//  XMPPCapabilites
//
//  Created by David Chiles on 11/18/14.
//  Copyright (c) 2014 David Chiles. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YapDatabase;

extern NSString *const kDatabaseViewGroupAll;
extern NSString *const kDatabaseViewXMPPServer;
extern NSString *const kDatabaseviewXMPPCapabilities;

@interface DatabaseView : NSObject

+ (BOOL)setupViewsForDatabase:(YapDatabase *)database;

@end
