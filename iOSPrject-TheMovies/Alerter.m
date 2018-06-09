//
//  Alerter.m
//  iOSPrject-TheMovies
//
//  Created by Omar Bdreldin on 5/11/18.
//  Copyright © 2018 Omar Bdreldin. All rights reserved.
//

#import "Alerter.h"

@implementation Alerter

+ (UIAlertController *) getAlertControllerForMessege: (NSString *) messege {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:[NSString stringWithFormat:@"%@", messege] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:ok];
    
    return alert;
}

@end
