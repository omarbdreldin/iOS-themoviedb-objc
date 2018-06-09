//
//  FavouriteButton.m
//  iOSPrject-TheMovies
//
//  Created by Omar Bdreldin on 5/8/18.
//  Copyright © 2018 Omar Bdreldin. All rights reserved.
//

#import "FavouriteButton.h"

@implementation FavouriteButton

-(void)setSelected:(BOOL)selected {
    _isSelected = selected;
    if (!selected) {
        [self setImage:[UIImage imageNamed:@"favblk.png"] forState:UIControlStateNormal];
    } else {
        [self setImage:[UIImage imageNamed:@"favylw.png"] forState:UIControlStateNormal];
    }
}

@end
