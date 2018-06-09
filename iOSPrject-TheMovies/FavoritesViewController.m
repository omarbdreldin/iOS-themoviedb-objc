//
//  SecondViewController.m
//  iOSPrject-TheMovies
//
//  Created by Omar Bdreldin on 5/6/18.
//  Copyright © 2018 Omar Bdreldin. All rights reserved.
//

#import "FavoritesViewController.h"

@interface FavoritesViewController ()

@end

@implementation FavoritesViewController {
    NSMutableArray *favouriteMovieList;
    DatabaseManeger *manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    manager = [DatabaseManeger sharedInstance];
//    manager.confirmationProtocol = self;
}

-(void)viewWillAppear:(BOOL)animated {
    [self prepareMovieList];
    [_tableView reloadData];
}

- (void)viewDidDisappear:(BOOL)animated {
    [self prepareMovieList];
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (favouriteMovieList) {
        return favouriteMovieList.count;
    }
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"favMovieCell" forIndexPath:indexPath];
//    NSLog(@"%ld", (long) indexPath.row);
    Movie *movie = [favouriteMovieList objectAtIndex:indexPath.row];
    
    UILabel *label = [cell viewWithTag:1];
    label.text = [NSString stringWithFormat:@"%@", movie.releaseYear];
    label = [cell viewWithTag:2];
    label.text = [NSString stringWithFormat:@"%.1f/10", [movie.voteAverage floatValue]];
    label = [cell viewWithTag:5];
    label.text = movie.title;
    UIImageView *imageView = [cell viewWithTag:3];
    NSURL *url = [NSURL URLWithString:movie.posterUrl];
    [imageView sd_setImageWithURL:url];
    FavouriteButton *button = [cell viewWithTag:4];
    button.tag = indexPath.row;
    [button setSelected: ([movie.isFavourite isEqualToNumber:[NSNumber numberWithInt:0]] ? NO : YES)];
    [button addTarget:self action:@selector(favouriteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    Movie *movie = [favouriteMovieList objectAtIndex:indexPath.row];
    FavouriteButton *button = [cell viewWithTag:4];
    button.tag = indexPath.row;
    [button setSelected:([movie.isFavourite isEqualToNumber:[NSNumber numberWithInt:0]] ? NO : YES)];
}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        Movie *movie = [favouriteMovieList objectAtIndex:indexPath.row];
//        movie.isFavourite = [NSNumber numberWithInt:0];
//        [manager setMovieAsFavourite:movie];
//        [favouriteMovieList removeObject:movie];
//        [self.tableView reloadData];
//    }
//}

#pragma mark - Database protocol methods

#pragma mark - My controls methods

- (void) favouriteButtonAction:(UIButton *) button{
//    Movie *movie = [favouriteMovieList objectAtIndex:button.tag];
//    button = (FavouriteButton *) button;
//    if ([movie.isFavourite isEqualToNumber:[NSNumber numberWithInt:1]]) {
//        // Remove from favourites
//        movie.isFavourite = [NSNumber numberWithInt:0];
//    } else {
//        // Set in favourites
//        movie.isFavourite = [NSNumber numberWithInt:1];
//    }
//    [manager setMovieAsFavourite:movie];
//    [button setSelected:!button.isSelected];
}

- (void) prepareMovieList {
    favouriteMovieList = [manager retreiveFavouriteMovies];
}

@end
