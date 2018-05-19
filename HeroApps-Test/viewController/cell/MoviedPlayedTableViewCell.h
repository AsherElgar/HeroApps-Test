//
//  MoviedPlayedTableViewCell.h
//  HeroApps-Test
//
//  Created by Asher Elgar on 18/05/2018.
//  Copyright © 2018 Asher Elgar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoviedPlayedTableViewCell : UITableViewCell
    
    @property (weak, nonatomic) IBOutlet UILabel *movieName;
    @property (weak, nonatomic) IBOutlet UILabel *yearMovie;
    @property BOOL *isAnimated;



@end
