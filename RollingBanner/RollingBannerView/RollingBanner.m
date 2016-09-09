//
//  RollingBanner.m
//  TuhuDemo
//
//  Created by huangyuan on 7/18/16.
//  Copyright © 2016 com.hy.tuhu. All rights reserved.
//

#import "RollingBanner.h"

typedef NS_ENUM(NSInteger, RollingBannerDirection) {
    RollingBannerDirection_Left = -1,
    RollingBannerDirection_Right = 1,
};

@interface RollingBanner ()<UIGestureRecognizerDelegate,UIScrollViewDelegate>

@property (nonatomic, strong)UIView * midContainter;

@property (nonatomic, strong)UIImageView * midImage;
@property (nonatomic, strong)UIImageView * leftImage;
@property (nonatomic, strong)UIImageView * rightImage;
@property (nonatomic, strong)UIPageControl * pageControl;
@property (nonatomic, strong)NSTimer * timer;

@property (nonatomic, assign)CGFloat portion;
@property (nonatomic, assign)CGFloat lastMoveX;

@end

@implementation RollingBanner


- (instancetype)initWithFrame:(CGRect)frame pictures:(NSArray *) pictures {
    
    return [self initWithFrame:frame pictures:pictures atIndex:0];
}

- (instancetype)initWithFrame:(CGRect)frame pictures:(NSArray *)pictures atIndex:(NSInteger)index {
    if ((self = [super initWithFrame:frame])) {
        self.sourceArr = pictures;
        self.pageControl.currentPage = index >= pictures.count? pictures.count -1 : index;
        self.delegate = self;
        [self setup];
        [self resetSubViews];
    }
    return self;
}

- (void)setup{
    self.contentSize = CGSizeMake(self.bounds.size.width*3, 0);
    self.contentOffset = CGPointMake(self.bounds.size.width, 0);
    self.portion = 0.6f;
    self.pagingEnabled = NO;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.bounces = NO;
    self.layer.masksToBounds = YES;
}

#pragma mark -   scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat moveX = scrollView.contentOffset.x - self.bounds.size.width;
    if (fabs(self.lastMoveX)>= self.bounds.size.width) {
        //prevent method (scrollViewWillEndDragging:withVelocity:targetContentOffset:)reload the image postion, so we reset scrollview to init postion and return,
        [self resetSubViews];
        self.lastMoveX = 0;
        return;
    }
    
    [self adjustSubViews:moveX];
    
    if (fabs(moveX) >= self.bounds.size.width) {
        [self completedHandler];
    }
    self.lastMoveX = moveX;
}

- (void)adjustSubViews:(CGFloat)moveX{
    [self move:self.midImage from:0 byX:moveX * (1 - self.portion)];
    [self move:self.leftImage from:self.bounds.size.width * (1- self.portion) byX:moveX * (1- self.portion)];
    [self move:self.rightImage from:self.bounds.size.width * (1 + self.portion) byX:(moveX) *  (1 - self.portion)];
}

- (CGFloat)targetOffsetForMoveX:(CGFloat)moveX velocity:(CGFloat)velocity{
    BOOL complete = fabs(moveX) >= self.bounds.size.width * 0.3 ||
                    (fabs(velocity) > 0 && fabs(moveX) >= self.bounds.size.width * 0.1 )? YES : NO;
    BOOL leftDirection = moveX > 0 ? YES : NO;
    if (complete) {
        if (leftDirection) {
            return self.bounds.size.width * 2;
        }
        return 0; //right Direction
    }else {
        return self.bounds.size.width;//cancel
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (self.pagingEnabled)return;
    CGFloat moveX = scrollView.contentOffset.x - self.bounds.size.width;
    CGFloat targetX = [self targetOffsetForMoveX:moveX velocity:velocity.x];
    if (targetX == self.bounds.size.width) {//cancel
        targetContentOffset->x = scrollView.contentOffset.x;
        [self setContentOffset:CGPointMake(targetX, targetContentOffset->y) animated:YES];
    } else {//complete
        targetContentOffset->x = targetX;
    }
}


#pragma mark - private Method
- (void)completedHandler{
    CGFloat moveX = self.contentOffset.x - self.bounds.size.width;
    if (fabs(moveX) >= self.bounds.size.width) {
        
        if (moveX > 0 && self.pageControl.currentPage + 1 < self.sourceArr.count) {
            self.pageControl.currentPage++;
        }else if (moveX >0 && self.pageControl.currentPage +1 == self.sourceArr.count){
            self.pageControl.currentPage = 0;
        }
        else if (self.pageControl.currentPage >= 1){
            self.pageControl.currentPage--;
        }else if (self.pageControl.currentPage == 0 && moveX < 0)
        {
            self.pageControl.currentPage = self.sourceArr.count - 1;
        }
        [self resetSubViews];
    }
}

- (void)resetSubViews {
    self.midImage.image = self.sourceArr[self.pageControl.currentPage];
    self.midImage.tag = self.pageControl.currentPage;
    self.midImage.frame = self.midContainter.bounds;
    
    NSInteger leftIndex = self.pageControl.currentPage - 1;
    if (leftIndex < 0) {
        leftIndex = self.sourceArr.count - 1;
    }
    self.leftImage.image = self.sourceArr[leftIndex];
    self.leftImage.tag = leftIndex;
    self.leftImage.frame = CGRectMake(self.bounds.size.width * (1- self.portion), 0, self.bounds.size.width, self.bounds.size.height);
    
    NSInteger rightIndex = self.pageControl.currentPage + 1;
    if (rightIndex >= self.sourceArr.count) {
        rightIndex = 0;
    }
    self.rightImage.image = self.sourceArr[rightIndex];
    self.rightImage.tag = rightIndex;
    self.rightImage.frame = CGRectMake(self.bounds.size.width * (1 + self.portion), 0, self.bounds.size.width, self.bounds.size.height);
    
    [self bringSubviewToFront:self.midContainter];
    [self sendSubviewToBack:self.leftImage];
    [self sendSubviewToBack:self.rightImage];
    [self setContentOffset:CGPointMake(self.bounds.size.width, 0) animated:NO];
    
    self.currentIndex = self.pageControl.currentPage;
}

#pragma mark - tools
- (void)move:(UIView *)view from:(CGFloat)start byX:(CGFloat)x {
    CGRect frame = view.frame;
    frame.origin.x = x + start;
    view.frame = frame;
}


#pragma mark - action

- (void)clicked:(UITapGestureRecognizer *)tap {
    if ([self.clickDelegate respondsToSelector:@selector(didclickViewAtIndex:)]) {
        [self.clickDelegate didclickViewAtIndex:tap.view.tag];
    }
}

- (void)nextPage:(id)sender
{
    [self setContentOffset:CGPointMake(0, 0) animated:YES];
}

#pragma mark - getter && setter

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.currentPage = 0;
    }
    return _pageControl;
}

- (UIView *)midContainter {
    if (!_midContainter) {
        _midContainter = [UIView new];
        _midContainter.frame = CGRectMake(self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height);
        _midContainter.clipsToBounds = YES;
        [self addSubview:_midContainter];
    }
    return  _midContainter;
}

- (UIImageView *)midImage {
    if (!_midImage) {
        _midImage = [UIImageView new];
        _midImage.frame = self.midContainter.bounds;
        _midImage.clipsToBounds = YES;
        [_midImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicked:)]];
        _midImage.userInteractionEnabled = YES;
        [self.midContainter addSubview:_midImage];
    }
    return _midImage;
}

- (UIImageView *)leftImage {
    if (!_leftImage) {
        _leftImage = [UIImageView new];
        _leftImage.frame = CGRectMake(self.bounds.size.width * (1- self.portion), 0, self.bounds.size.width, self.bounds.size.height);
        [_leftImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicked:)]];
        _leftImage.userInteractionEnabled = YES;
        [self insertSubview:self.leftImage  belowSubview:self.midContainter];
    }
    return _leftImage;
}

- (UIImageView *)rightImage {
    if (!_rightImage) {
        _rightImage = [UIImageView new];
        _rightImage.frame = CGRectMake(self.bounds.size.width * (1 + self.portion), 0, self.bounds.size.width, self.bounds.size.height);
        [_rightImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicked:)]];
        _rightImage.userInteractionEnabled = YES;
        [self insertSubview:self.rightImage belowSubview:self.midContainter];
    }
    return _rightImage;
}


- (void)setSourceArr:(NSArray *)sourceArr {
    _sourceArr = sourceArr;
    self.pageControl.numberOfPages = sourceArr.count;
}

- (void)setAutoRolling:(BOOL)autoRolling {
    _autoRolling = autoRolling;
    if (autoRolling) {
        [self.timer invalidate];
        self.timer = nil;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:8 target:self selector:@selector(nextPage:) userInfo:nil repeats:YES];
    }else {
        [self.timer invalidate];
        self.timer = nil;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
