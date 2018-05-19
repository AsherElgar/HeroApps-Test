//
//  Hero.h
//  HeroApps-Test
//
//  Created by Asher Elgar on 18/05/2018.
//  Copyright © 2018 Asher Elgar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Hero : NSObject
    
    @property(strong, nonatomic) NSString *titleName;
    
    @property(strong, nonatomic) NSString *nickName;

    @property(strong, nonatomic) NSString *yearBorn;
    
    @property(strong, nonatomic) NSString *powers;

    @property(strong, nonatomic) NSString *originalActor;

    @property(strong, nonatomic) NSString *imageURL;

    @property(strong, nonatomic) NSDictionary *moviesPlayed;


@end
