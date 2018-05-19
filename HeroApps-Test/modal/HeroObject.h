//
//  HeroObject.h
//  HeroApps-Test
//
//  Created by Asher Elgar on 19/05/2018.
//  Copyright © 2018 Asher Elgar. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface HeroObject : NSManagedObject

@property(strong, nonatomic) NSString *titleName;

@property(strong, nonatomic) NSString *nickName;

@property(strong, nonatomic) NSString *yearBorn;

@property(strong, nonatomic) NSString *powers;

@property(strong, nonatomic) NSString *originalActor;

@property(strong, nonatomic) NSData *image;

@property(strong, nonatomic) NSDictionary *moviesPlayed;
@property(strong, nonatomic) NSString *moviesPlayedString;

@end
