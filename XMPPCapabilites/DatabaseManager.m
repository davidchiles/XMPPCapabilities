//
//  DatabaseManager.m
//  XMPPCapabilites
//
//  Created by David Chiles on 11/18/14.
//  Copyright (c) 2014 David Chiles. All rights reserved.
//

#import "DatabaseManager.h"
#import "YapDatabase.h"
#import "DatabaseView.h"

@interface DatabaseManager ()

@property (nonatomic, strong) YapDatabase *database;
@property (nonatomic, strong) YapDatabaseConnection *databaseConnection;

@end

@implementation DatabaseManager

- (instancetype)initWithFilePath:(NSString *)filePath
{
    if (self = [super init]) {
        self.database = [[YapDatabase alloc] initWithPath:filePath];
        self.databaseConnection = [self newConnection];;
        self.databaseConnection.name = NSStringFromClass([self class]);
        [DatabaseView setupViewsForDatabase:self.database];
    }
    return self;
}

- (YapDatabaseConnection *)newConnection
{
    return [self.database newConnection];
}

- (void)removeAllItems
{
    [self.databaseConnection readWriteWithBlock:^(YapDatabaseReadWriteTransaction *transaction) {
        [transaction removeAllObjectsInAllCollections];
    }];
}

@end
