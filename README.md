# HYRollingBanner
Parallax Rolling Banner
```objc
    NSMutableArray * image = [NSMutableArray new];
    [image addObject:[UIImage imageNamed:@"1.jpg"]];
    [image addObject:[UIImage imageNamed:@"0.jpg"]];
    [image addObject:[UIImage imageNamed:@"2.jpg"]];

    RollingBanner * banner = [[RollingBanner alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, kFitH(300)) pictures:image atIndex:1];
    [self.view addSubview:banner];
```

# Paging
```objc
    banner.pagingEnabled = YES;  //if you wannna system paging rather than the custom paging
````

![](https://github.com/Arbalest313/gitRecord/blob/master/RollingBanner/RBPagingC.gif?raw=true)


# Target Postion -- Custom Paing
![](https://github.com/Arbalest313/gitRecord/blob/master/RollingBanner/RBTargetX-C.gif?raw=true)


# 如果你在天朝
[戳这里](http://hyyy.me/2016/08/15/RollingBanner/)
