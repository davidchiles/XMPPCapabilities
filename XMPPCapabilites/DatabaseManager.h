//
//  DatabaseManager.h
//  XMPPCapabilites
//
//  Created by David Chiles on 11/18/14.
//  Copyright (c) 2014 David Chiles. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YapDatabaseConnection;

@interface DatabaseManager : NSObject

- (instancetype)initWithFilePath:(NSString *)filePath;

- (YapDatabaseConnection *)newConnection;
- (void)removeAllItems;


@end
