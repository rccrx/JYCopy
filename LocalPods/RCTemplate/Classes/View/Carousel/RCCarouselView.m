//
//  RCCarouselView.m
//  RCTemplate
//
//  Created by crx on 2021/11/16.
//

#import "RCCarouselView.h"
#import "RCPageControl.h"

@interface RCCarouselView () <UIScrollViewDelegate>

@property (nonatomic, assign) UIEdgeInsets imageEdgeInsets;
@property (nonatomic, assign) CGFloat scrollViewWidth;
@property (nonatomic, assign) CGFloat scrollViewHeight;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) NSUInteger imageCount;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation RCCarouselView

#pragma mark - Life Cycle & Override
- (void)dealloc {
    NSLog(@"%@: %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
}

- (void)didMoveToSuperview {
    if (self.superview == nil) {
        [self.timer invalidate];
        self.timer = nil;
        self.enableAutoslide = NO;
    }
}

- (instancetype)initWithImageEdgeInsets:(UIEdgeInsets)imageEdgeInsets viewWidth:(CGFloat)viewWidth viewHeight:(CGFloat)viewHeight {
    if (self = [super init]) {
        self.timeInterval = 5;
        self.imageEdgeInsets = imageEdgeInsets;
        self.scrollViewWidth = viewWidth;
        self.scrollViewHeight = viewHeight;
        
        self.scrollView = [[UIScrollView alloc] init];
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.delegate = self;
        [self addSubview:self.scrollView];
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self);
            make.width.equalTo(@(self.scrollViewWidth));
            make.height.equalTo(@(self.scrollViewHeight));
        }];
    }
    return self;
}

#pragma mark - Setter
- (void)setImages:(NSArray<UIImage *> *)images {
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    _images = [images copy];
    self.imageCount = self.images.count;
    if (self.imageCount == 0) {
        self.scrollView.contentSize = CGSizeZero;
        self.scrollView.contentOffset = CGPointZero;
        self.pageControl.hidden = YES;
        return;
    }
    
    NSUInteger count = self.imageCount + 2;
    for (int i = 0; i < count; i++) {
        NSUInteger idx = [self getImageIndexWithImageViewIndex:i];
        UIImageView *iv = [[UIImageView alloc] initWithImage:self.images[idx]];
        iv.frame = CGRectMake(self.scrollViewWidth * i + self.imageEdgeInsets.left,
                              self.imageEdgeInsets.top,
                              self.scrollViewWidth - self.imageEdgeInsets.left - self.imageEdgeInsets.right,
                              self.scrollViewHeight - self.imageEdgeInsets.top - self.imageEdgeInsets.bottom);
        iv.backgroundColor = UIColor.systemPurpleColor;
        iv.layer.cornerRadius = 3;
        [self.scrollView addSubview:iv];
    }
    self.scrollView.contentSize = CGSizeMake(self.scrollViewWidth * count, self.scrollViewHeight);
    self.scrollView.contentOffset = CGPointMake(self.scrollViewWidth, 0);
    self.pageControl.hidden = NO;
    self.pageControl.numberOfPages = self.imageCount;
    self.pageControl.currentPage = [self getPageControlCurrentPageWithScrollViewContentOffset:self.scrollView.contentOffset];
}

- (void)setPageControl:(UIView<RCPageControl> *)pageControl {
    _pageControl = pageControl;
    self.pageControl.numberOfPages = self.imageCount;
    [self addSubview:self.pageControl];
}

- (void)setEnableAutoslide:(BOOL)enableAutoslide {
    _enableAutoslide = enableAutoslide;
    if (self.enableAutoslide) {
        if (!self.timer) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
        } else {
            self.timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:self.timeInterval];
        }
    } else {
        self.timer.fireDate = [NSDate distantFuture];
    }
}

#pragma mark - Action
- (void)timerAction:(NSTimer *)timer {
    if (self.imageCount == 0) {
        return;
    }
    
    CGPoint nextOffset = CGPointMake(self.scrollView.contentOffset.x + self.scrollViewWidth, self.scrollView.contentOffset.y); // 动画停止时会调整contentOffset，比如最后一个imageView会调整到第1个imageView的位置；contentOffset设置为逐增，因为如果变小（比如从倒数第二个imageView直接跳到第1个imageView时），则动画效果是图片从左边出现而不是右边
    [self.scrollView setContentOffset:nextOffset animated:YES];
    self.pageControl.currentPage = [self getPageControlCurrentPageWithScrollViewContentOffset:nextOffset];
}

#pragma mark - Private
/**
 * 由于imageView的数量是image数量+2（第0个imageView是最后一张image，最后一个imageView是第0张image），
 * 所以需要将imageView的索引转换成image的索引。
 */
- (NSUInteger)getImageIndexWithImageViewIndex:(NSUInteger)imageViewIdx {
    return ((imageViewIdx - 1) + self.imageCount) % self.imageCount; // 求余之前加self.imageCount是为了消除负数
}

- (NSUInteger)getPageControlCurrentPageWithScrollViewContentOffset:(CGPoint)contentOffset {
    NSUInteger imageViewIdx = round(contentOffset.x / self.scrollViewWidth);
    return [self getImageIndexWithImageViewIndex:imageViewIdx];
}

/** 滑动到最后一页时设置跳到第0张图片，滑动到第0页时设置跳到最后一张图片 */
- (void)modifyScrollViewContentOffset:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x == self.scrollViewWidth * (self.imageCount + 1)) {
        scrollView.contentOffset = CGPointMake(self.scrollViewWidth * 1, scrollView.contentOffset.y);
    } else if (scrollView.contentOffset.x == 0) {
        scrollView.contentOffset = CGPointMake(self.scrollViewWidth * self.imageCount, scrollView.contentOffset.y);
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self modifyScrollViewContentOffset:scrollView];
    self.pageControl.currentPage = [self getPageControlCurrentPageWithScrollViewContentOffset:scrollView.contentOffset];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self modifyScrollViewContentOffset:scrollView];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.timer.fireDate = [NSDate distantFuture];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    self.timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:self.timeInterval];
}

@end
