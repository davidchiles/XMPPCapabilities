//
//  AppDelegate.h
//  XMPPCapabilites
//
//  Created by David Chiles on 11/18/14.
//  Copyright (c) 2014 David Chiles. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DatabaseManager;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) DatabaseManager *databaseManager;

+ (AppDelegate *)sharedInstance;

@end

