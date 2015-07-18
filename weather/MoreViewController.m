//
//  MoreViewController.m
//  weather
//
//  Created by deng on 15/6/17.
//  Copyright (c) 2015年 deng. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController
NSArray * array;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    array = @[@"珠海",@"广州",@"深圳",@"北京"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)finish:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


#pragma mark - 数据源方法
#pragma mark 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return array.count;
}

#pragma mark 返回每一行的cell
#pragma mark 每当有一个cell进入视野范围内就会调用
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *ID = @"C1";
    
    // 1.从缓存池中取出可循环利用的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // 2.如果缓存池中没有可循环利用的cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.detailTextLabel.text = [array objectAtIndex:indexPath.row];
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.textColor  = [UIColor whiteColor];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:18];
    return cell;
}

#pragma mark 点击cell事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self dismissViewControllerAnimated:YES completion:^{
    
        NSString * str = [NSString stringWithFormat: @"%d", (int)indexPath.row ];
        NSDictionary * dataDict = [NSDictionary dictionaryWithObject:str forKey:@"city" ];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"selectCity" object:nil userInfo:dataDict];
    
    }];
}



@end
