//
//  VideosCollectionViewController.m
//  iOSPrject-TheMovies
//
//  Created by Omar Bdreldin on 5/7/18.
//  Copyright © 2018 Omar Bdreldin. All rights reserved.
//

#import "VideosCollectionViewController.h"

@implementation VideosCollectionViewController

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_videosList) {
        return _videosList.count;
    }
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"videoCell" forIndexPath:indexPath];
    
    UIImageView *imageView = [cell viewWithTag:1];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://i.ytimg.com/vi/%@/default.jpg", [_videosList objectAtIndex:indexPath.item]]];
    
    [imageView sd_setImageWithURL:url];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.youtube.com/watch?v=%@", [_videosList objectAtIndex:indexPath.item]]];
    [[UIApplication sharedApplication] openURL:url];
}

@end
