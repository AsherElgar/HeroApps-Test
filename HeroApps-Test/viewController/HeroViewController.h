//
//  HeroViewController.h
//  HeroApps-Test
//
//  Created by Asher Elgar on 18/05/2018.
//  Copyright © 2018 Asher Elgar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Hero.h"


@interface HeroViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *yearBorn;
@property (weak, nonatomic) IBOutlet UILabel *powers;
@property (weak, nonatomic) IBOutlet UILabel *originalActor;
@property (weak, nonatomic) IBOutlet UIImageView *heroImage;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong) NSManagedObject *herodb;
@property (strong) NSMutableArray *heroArray;
@property(strong, nonatomic) NSMutableArray<Hero *> *heroesData;
@end

