//
//  SecondController.m
//  RollingBanner
//
//  Created by huangyuan on 8/2/16.
//  Copyright © 2016 com.hy.banner. All rights reserved.
//

#import "SecondController.h"
#import "RollingBanner.h"
@interface SecondController ()

@end

@implementation SecondController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"如丝般顺滑";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    NSMutableArray * image = [NSMutableArray new];
    [image addObject:[UIImage imageNamed:@"1.jpg"]];
    [image addObject:[UIImage imageNamed:@"0.jpg"]];
    [image addObject:[UIImage imageNamed:@"2.jpg"]];
    
    RollingBanner * banner = [[RollingBanner alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, kFitH(300)) pictures:image atIndex:1];
    [self.view addSubview:banner];
    
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

@end
