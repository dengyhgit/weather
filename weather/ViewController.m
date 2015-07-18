//
//  ViewController.m
//  weather
//
//  Created by deng on 15/6/16.
//  Copyright (c) 2015年 deng. All rights reserved.
//

#import "ViewController.h"
#import "MoreViewController.h"

@interface ViewController ()

@end

@implementation ViewController

NSMutableDictionary * resDict;
NSArray *d;
UIImageView *customBackgournd;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //显示天气图片
    customBackgournd = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"s.jpg"]];
    customBackgournd.frame = self.view.frame;
    customBackgournd.contentMode = UIViewContentModeScaleAspectFill ;
    [self.view addSubview:customBackgournd];
    [self.view insertSubview:customBackgournd atIndex:0];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectCity:) name:@"selectCity" object:nil];

    [self startLocation];
}


//开始定位
-(void)startLocation{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestAlwaysAuthorization];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    [self.locationManager startUpdatingLocation];
    
}

//检测是否支持定位
- (void)locationManager: (CLLocationManager *)manager
       didFailWithError: (NSError *)error {
    
    NSString *errorString;
    [manager stopUpdatingLocation];
    switch([error code]) {
        case kCLErrorDenied:
            errorString = @"Access to Location Services denied by user";
            break;
        case kCLErrorLocationUnknown:
            errorString = @"Location data unavailable";
            break;
        default:
            errorString = @"An unknown error has occurred";
            break;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
}

//定位代理经纬度回调
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    NSLog(@"%@",[NSString stringWithFormat:@"经度:%3.5f\n纬度:%3.5f",newLocation.coordinate.latitude,newLocation.coordinate.longitude]);
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
      
        for (CLPlacemark * placemark in placemarks) {
            NSDictionary *info = [placemark addressDictionary];
            NSString * st = [info objectForKey:@"City"];
            if([st isEqual:@"珠海市"]){
                NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(update:) object:@"0"];
                [thread start];
            }else if([st isEqual:@"广州市"]){
                NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(update:) object:@"1"];
                [thread start];
            }else if([st isEqual:@"深圳市"]){
                NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(update:) object:@"2"];
                [thread start];
            }else if([st isEqual:@"北京市"]){
                NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(update:) object:@"3"];
                [thread start];
            }
        }
    }];
    [self.locationManager stopUpdatingLocation];
    
}
/**
 *  <#Description#>
 *
 *  @param cityid cityid 城市编号
 */
-(void)update:(NSString*)cityid{
    NSString *urlStr;
    //珠海
    if([cityid isEqual:@"0"]){
        urlStr=[NSString stringWithFormat:@"http://api.map.baidu.com/telematics/v3/weather?location=%%E7%%8F%%A0%%E6%%B5%%B7&output=json&ak=xfkg5isLkdyXDGAPYezFjtpb"];
    }
    //广州
    if([cityid isEqual:@"1"]){
        
        urlStr=[NSString stringWithFormat:@"http://api.map.baidu.com/telematics/v3/weather?location=%%E5%%B9%%BF%%E5%%B7%%9E&output=json&ak=xfkg5isLkdyXDGAPYezFjtpb"];
    }
    //深圳
    if([cityid isEqual:@"2"]){
        urlStr=[NSString stringWithFormat:@"http://api.map.baidu.com/telematics/v3/weather?location=%%E6%%B7%%B1%%E5%%9C%%B3&output=json&ak=xfkg5isLkdyXDGAPYezFjtpb"];
    }
    //北京
    if([cityid isEqual:@"3"]){
        urlStr=[NSString stringWithFormat:@"http://api.map.baidu.com/telematics/v3/weather?location=%%E5%%8C%%97%%E4%%BA%%AC&output=json&ak=xfkg5isLkdyXDGAPYezFjtpb"];
    }

   
    NSURL *url=[NSURL URLWithString:urlStr];
    //直接从原始地址读
    NSURLRequest * request2 = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0];
    NSData *data=[NSURLConnection sendSynchronousRequest:request2 returningResponse:nil error:nil];
    if(data == nil){
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"网络连接失败！" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alter show];
        return;
    }
    resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    d =  resDict[@"results"];
    
    _weather01.text = @"";
    _weather01.text = d[0][@"weather_data"][0][@"temperature"];
    _currentWeather.text = @"";
    _currentWeather.text = d[0][@"weather_data"][0][@"date"];
    
    _weather.text = d[0][@"weather_data"][0][@"weather"];
    _wind.text = d[0][@"weather_data"][0][@"wind"];
    //显示天气图片
    if([d[0][@"weather_data"][0][@"weather"] isEqualToString:@"阵雨"] ||
       [d[0][@"weather_data"][0][@"weather"] isEqualToString:@"小雨"] ||
       [d[0][@"weather_data"][0][@"weather"] isEqualToString:@"中雨"] ||
       [d[0][@"weather_data"][0][@"weather"] isEqualToString:@"大雨"] ||
       [d[0][@"weather_data"][0][@"weather"] isEqualToString:@"暴雨"] ||
       [d[0][@"weather_data"][0][@"weather"] isEqualToString:@"大暴雨"] ||
       [d[0][@"weather_data"][0][@"weather"] isEqualToString:@"特大暴雨"]){
        customBackgournd.image = [UIImage imageNamed:@"sy.jpg"];
    }else if([d[0][@"weather_data"][0][@"weather"] isEqualToString:@"雷阵雨"]){
        customBackgournd.image = [UIImage imageNamed:@"ly.jpg"];
    }else if([d[0][@"weather_data"][0][@"weather"] isEqualToString:@"多云"]){
        customBackgournd.image = [UIImage imageNamed:@"dy.jpg"];
    }else{
        customBackgournd.image = [UIImage imageNamed:@"s.jpg"];
    }
    
    
    NSString * urlWeb = d[0][@"weather_data"][0][@"dayPictureUrl"];
    UIImage * result = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlWeb]]];
    [_img01 setImage:result];
    
    NSString * urlWeb2 = d[0][@"weather_data"][0][@"nightPictureUrl"];
    UIImage * result2 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlWeb2]]];
    [_img_n1 setImage:result2];
    
    _weather02.text = d[0][@"weather_data"][1][@"temperature"];
    _tomorrow.text = d[0][@"weather_data"][1][@"date"];
    urlWeb = d[0][@"weather_data"][1][@"dayPictureUrl"];
    result = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlWeb]]];
    [_img02 setImage:result];
    
    urlWeb2 = d[0][@"weather_data"][1][@"nightPictureUrl"];
    result2 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlWeb2]]];
    [_img_n2 setImage:result2];
    
    
    urlWeb = d[0][@"weather_data"][2][@"dayPictureUrl"];
    result = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlWeb]]];
    [_img03 setImage:result];
    _weather03.text = d[0][@"weather_data"][2][@"temperature"];
    _aftertomorrow.text = d[0][@"weather_data"][2][@"date"];
    
    urlWeb2 = d[0][@"weather_data"][2][@"nightPictureUrl"];
    result2 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlWeb2]]];
    [_img_n3 setImage:result2];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)updateWeather:(id)sender {
    
    if([self.navigationItem.title isEqual:@"珠海"]){
        NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(update:) object:@"0"];
        [thread start];
    }
    if([self.navigationItem.title isEqual:@"广州"]){
        NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(update:) object:@"1"];
        [thread start];
    }
    if([self.navigationItem.title isEqual:@"深圳"]){
        NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(update:) object:@"2"];
        [thread start];
    }
    if([self.navigationItem.title isEqual:@"北京"]){
        NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(update:) object:@"3"];
        [thread start];
    }
    
}

- (IBAction)onclickMore:(id)sender {
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"More" bundle:nil];
    MoreViewController *morePage = [mainStoryBoard instantiateViewControllerWithIdentifier:@"moreNavigation"];
    morePage.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    morePage.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:morePage animated:YES completion:nil];
}

- (IBAction)onclickTomorrow:(id)sender {
}

-(void) selectCity:(NSNotification *)notification{
    NSDictionary * theData = [notification userInfo];
    NSString * cityid = [theData objectForKey:@"city"];
    NSLog(@"%@", cityid);
    
    if([cityid isEqual:@"0"]){
        self.navigationItem.title  = @"珠海";
    }
    if([cityid isEqual:@"1"]){
       
        self.navigationItem.title = @"广州";
    }
    if([cityid isEqual:@"2"]){
        self.navigationItem.title  = @"深圳";
    }
    if([cityid isEqual:@"3"]){
        self.navigationItem.title  = @"北京";
    }
    
    
    NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(update:) object:cityid];
    [thread start];
}
- (IBAction)onclickAfter:(id)sender {
}
@end

