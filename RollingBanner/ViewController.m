//
//  ViewController.m
//  RollingBanner
//
//  Created by huangyuan on 7/15/16.
//  Copyright © 2016 com.hy.banner. All rights reserved.
//

#import "ViewController.h"
#import "SecondController.h"

#import "RollingBanner/RollingBanner.h"

@interface ViewController ()
@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"RollingBanner";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSMutableArray * image = [NSMutableArray new];
    [image addObject:[UIImage imageNamed:@"1.jpg"]];
    [image addObject:[UIImage imageNamed:@"0.jpg"]];
    [image addObject:[UIImage imageNamed:@"2.jpg"]];

    RollingBanner * banner = [[RollingBanner alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, kFitH(300)) pictures:image atIndex:1];
    [self.view addSubview:banner];
    banner.pagingEnabled = YES;
//    banner.autoRolling = YES;

    
    UIButton *toDVCButton = [[UIButton alloc] init];
    [toDVCButton setTitle:@"优化" forState:UIControlStateNormal];
    [toDVCButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    toDVCButton.frame = CGRectMake(100, kFitH(300)+100, 100, 30);
    [self.view addSubview:toDVCButton];
    
    [toDVCButton addTarget:self action:@selector(jumpToNext) forControlEvents:UIControlEventTouchUpInside];
}

- (void)jumpToNext {
    SecondController * vc =[SecondController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
