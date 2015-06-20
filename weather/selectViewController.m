//
//  selectViewController.m
//  weather
//
//  Created by deng on 15/6/17.
//  Copyright (c) 2015年 deng. All rights reserved.
//

#import "selectViewController.h"

@interface selectViewController ()

@end

@implementation selectViewController


- (id)initWithFrame:(CGRect)frame
{
    
    if (frame.size.height<200) {
        frameHeight = 200;
    }else{
        frameHeight = frame.size.height;
    }
    tabheight = frameHeight-30;
    
    frame.size.height = 30.0f;
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //textField.delegate = self;
    }
    
    if(self){
        showList = NO; //默认不显示下拉框
        
        _tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, frame.size.width + 80 , 0)];
        _tv.delegate = self;
        _tv.dataSource = self;
        _tv.backgroundColor = [UIColor grayColor];
        _tv.separatorColor = [UIColor lightGrayColor];
        _tv.hidden = YES;
        [self addSubview:_tv];
        
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, frame.size.width + 80, 30)];
        _textField.font = [UIFont systemFontOfSize:8.0f];
        //textField.userInteractionEnabled = NO;
        _textField.borderStyle=UITextBorderStyleRoundedRect;//设置文本框的边框风格
        [_textField addTarget:self action:@selector(dropdown) forControlEvents:UIControlEventAllTouchEvents];
        [self addSubview:_textField];
        
    }
    return self;
}


-(void)dropdown{
    [_textField resignFirstResponder];
    if (showList) {//如果下拉框已显示，什么都不做
        return;
    }else {//如果下拉框尚未显示，则进行显示
        
        CGRect sf = self.frame;
        sf.size.height = frameHeight;
        
        //把dropdownList放到前面，防止下拉框被别的控件遮住
        [self.superview bringSubviewToFront:self];
        _tv.hidden = NO;
        showList = YES;//显示下拉框
        
        CGRect frame = tv.frame;
        frame.size.height = 0;
        _tv.frame = frame;
        frame.size.height = tabheight;
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        self.frame = sf;
        _tv.frame = frame;
        [UIView commitAnimations];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_tableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    
    cell.textLabel.text = [_tableArray objectAtIndex:[indexPath row]];
    cell.textLabel.font = [UIFont systemFontOfSize:8.0f];
    cell.accessoryType  = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _textField.text = [_tableArray objectAtIndex:[indexPath row]];
    showList = NO;
    tv.hidden = YES;
    
    CGRect sf = self.frame;
    sf.size.height = 30;
    self.frame = sf;
    CGRect frame = tv.frame;
    frame.size.height = 0;
    _tv.frame = frame;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
