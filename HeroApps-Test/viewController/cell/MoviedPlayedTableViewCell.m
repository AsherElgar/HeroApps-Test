//
//  MoviedPlayedTableViewCell.m
//  HeroApps-Test
//
//  Created by Asher Elgar on 18/05/2018.
//  Copyright © 2018 Asher Elgar. All rights reserved.
//

#import "MoviedPlayedTableViewCell.h"

@implementation MoviedPlayedTableViewCell
    
    @synthesize movieName = _movieName;
    @synthesize yearMovie = _yearMovie;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
    


@end
