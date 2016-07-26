//
//  ViewController.m
//  RollingBanner
//
//  Created by huangyuan on 7/15/16.
//  Copyright © 2016 com.hy.banner. All rights reserved.
//

#import "ViewController.h"
#import "RollingBanner/RollingBanner.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray * picts = @[@"0",@"1",@"2",@"3"];
    NSMutableArray * image = [NSMutableArray new];
    for (NSString * name in picts) {
        [image addObject:[UIImage imageNamed:name]];
    }
    RollingBanner * banner = [[RollingBanner alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 200) pictures:image atIndex:1];
    [self.view addSubview:banner];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
