//
//  RCViewController.m
//  SampleNetwork
//
//  Created by 古山 健司 on 12/12/29.
//  Copyright (c) 2012年 TF. All rights reserved.
//

#import "RCViewController.h"
#import "RCNetworkManager.h"
#import "RCPerson.h"

@interface RCViewController ()

@end

@implementation RCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    RCPerson *taro = [[RCPerson alloc] init];
    taro.name = @"Taro";
    taro.age = [NSNumber numberWithInt:24];
    taro.livingarea = @"Tokyo";
    taro.shokugyo = @"Teacher";
    
    RCPerson *jiro = [[RCPerson alloc] init];
    jiro.name = @"Jiro";
    jiro.age = [NSNumber numberWithInt:22];
    jiro.livingarea = @"Kanagawa";
    jiro.shokugyo = @"Student";
    
    RCPerson *sabu = [[RCPerson alloc] init];
    sabu.name = @"Saburo";
    sabu.age = [NSNumber numberWithInt:20];
    sabu.livingarea = @"Saitama";
    sabu.shokugyo = @"Student";
    
    NSArray* array = [NSArray arrayWithObjects:[taro jsonToDictionary], [jiro jsonToDictionary], [sabu jsonToDictionary], nil];
    [taro release];
    [jiro release];
    
    NSData *data = [RCUtility createFormatData:array];
    NSString *myString = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    NSLog(@"%@", myString);
    [[RCNetworkManager sharedManager] hoge];
    
    [[RCNetworkManager sharedManager] fugaWith:data];
   
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}


@end
