//
//  AppDelegate.h
//  HeroApps-Test
//
//  Created by Asher Elgar on 18/05/2018.
//  Copyright © 2018 Asher Elgar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

