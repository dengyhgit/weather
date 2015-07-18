//
//  ViewController.h
//  weather
//
//  Created by deng on 15/6/16.
//  Copyright (c) 2015年 deng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController<CLLocationManagerDelegate>{

}
@property (strong, nonatomic) CLLocationManager* locationManager;

@property (weak, nonatomic) IBOutlet UILabel *today;

@property (weak, nonatomic) IBOutlet UILabel *tomorrow;

@property (weak, nonatomic) IBOutlet UILabel *aftertomorrow;

@property (weak, nonatomic) IBOutlet UILabel *weather01;

@property (weak, nonatomic) IBOutlet UILabel *weather02;

@property (weak, nonatomic) IBOutlet UILabel *weather03;

@property (weak, nonatomic) IBOutlet UILabel *currentWeather;

@property (weak, nonatomic) IBOutlet UIImageView *img01;
@property (weak, nonatomic) IBOutlet UIImageView *img02;
@property (weak, nonatomic) IBOutlet UIImageView *img03;
@property (weak, nonatomic) IBOutlet UIImageView *img_n1;
@property (weak, nonatomic) IBOutlet UIImageView *img_n2;
@property (weak, nonatomic) IBOutlet UIImageView *img_n3;
- (IBAction)updateWeather:(id)sender;
- (IBAction)onclickMore:(id)sender;



@end

