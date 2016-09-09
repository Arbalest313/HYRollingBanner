//
//  RollingBanner.h
//  TuhuDemo
//
//  Created by huangyuan on 7/18/16.
//  Copyright © 2016 com.hy.tuhu. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RollingBannerDelegate <NSObject>
- (void)didclickViewAtIndex:(NSInteger)index;
@end

@interface RollingBanner : UIScrollView

- (instancetype)initWithFrame:(CGRect)frame pictures:(NSArray *) pictures;

- (instancetype)initWithFrame:(CGRect)frame pictures:(NSArray *) pictures atIndex:(NSInteger)index;

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, copy)   NSArray * sourceArr;
@property (nonatomic, weak)   id <RollingBannerDelegate>  clickDelegate;
@property (nonatomic, assign) BOOL autoRolling;

@end
