//
//  SecondController.h
//  RollingBanner
//
//  Created by huangyuan on 8/2/16.
//  Copyright © 2016 com.hy.banner. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kSCREEN [[UIScreen mainScreen]bounds]
#define kSCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height
#define kSCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width


//适配各种屏幕 设计稿按iPhone6的屏幕来适配
#define kFitH(oHeight) (oHeight)*kSCREEN_HEIGHT/667.0
#define kFitW(oWidth) (oWidth)*kSCREEN_WIDTH/375.0


@interface SecondController : UIViewController

@end
