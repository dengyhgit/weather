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
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"s.jpg"]]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectCity:) name:@"selectCity" object:nil];
    
    //缓存存在时读缓存
    NSString *urlStr=[NSString stringWithFormat:@"http://api.map.baidu.com/telematics/v3/weather?location=%%E7%%8F%%A0%%E6%%B5%%B7&output=json&ak=xfkg5isLkdyXDGAPYezFjtpb"];
    NSURL *url=[NSURL URLWithString:urlStr];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
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
    NSLog(@"%@",d[0][@"weather_data"][0][@"date"]);
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

-(void)update:(NSString*)cityid{
    NSString *urlStr;
    if([cityid isEqual:@"0"]){
        urlStr=[NSString stringWithFormat:@"http://api.map.baidu.com/telematics/v3/weather?location=%%E7%%8F%%A0%%E6%%B5%%B7&output=json&ak=xfkg5isLkdyXDGAPYezFjtpb"];
    }
    if([cityid isEqual:@"1"]){
        
        urlStr=[NSString stringWithFormat:@"http://api.map.baidu.com/telematics/v3/weather?location=%%E5%%B9%%BF%%E5%%B7%%9E&output=json&ak=xfkg5isLkdyXDGAPYezFjtpb"];
    }
    if([cityid isEqual:@"2"]){
        urlStr=[NSString stringWithFormat:@"http://api.map.baidu.com/telematics/v3/weather?location=%%E6%%B7%%B1%%E5%%9C%%B3&output=json&ak=xfkg5isLkdyXDGAPYezFjtpb"];
    }
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
    NSLog(@"%@",d[0][@"weather_data"][0][@"date"]);
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
        [self update:@"0"];
    }
    if([self.navigationItem.title isEqual:@"广州"]){
        [self update:@"1"];
    }
    if([self.navigationItem.title isEqual:@"深圳"]){
        [self update:@"2"];
    }
    if([self.navigationItem.title isEqual:@"北京"]){
        [self update:@"3"];
    }
    
}

- (IBAction)onclickMore:(id)sender {
    UIStoryboard *mainStoryBoard=[UIStoryboard storyboardWithName:@"More" bundle:nil];
    MoreViewController *morePage=[mainStoryBoard instantiateViewControllerWithIdentifier:@"moreNavigation"];
    morePage.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    morePage.modalPresentationStyle=UIModalPresentationFormSheet;
    [self presentViewController:morePage animated:YES completion:nil];
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
    
    
    [self update:cityid];
}
@end

