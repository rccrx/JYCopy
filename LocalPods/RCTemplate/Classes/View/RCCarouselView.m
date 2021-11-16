//
//  RCCarouselView.m
//  RCTemplate
//
//  Created by crx on 2021/11/16.
//

#import "RCCarouselView.h"

@interface RCCarouselView () <UIScrollViewDelegate>

@property (nonatomic, assign) UIEdgeInsets imageEdgeInsets;
@property (nonatomic, assign) CGFloat scrollViewWidth;
@property (nonatomic, assign) CGFloat scrollViewHeight;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) NSUInteger imageCount;

@end

@implementation RCCarouselView

- (instancetype)initWithImageEdgeInsets:(UIEdgeInsets)imageEdgeInsets viewWidth:(CGFloat)viewWidth viewHeight:(CGFloat)viewHeight {
    if (self = [super init]) {
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

- (void)setImages:(NSArray<UIImage *> *)images {
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.scrollView.contentSize = CGSizeZero;
    self.scrollView.contentOffset = CGPointZero;
    
    _images = [images copy];
    self.imageCount = self.images.count;
    if (self.imageCount == 0) {
        return;
    }
    
    NSUInteger count = self.imageCount + 2;
    for (int i = 0; i < count; i++) {
        NSUInteger idx = ((i - 1) + self.imageCount) % self.imageCount; // 求余之前加self.imageCount是为了消除负数
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
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x == self.scrollViewWidth * (self.imageCount + 1)) {
        scrollView.contentOffset = CGPointMake(self.scrollViewWidth * 1, scrollView.contentOffset.y);
    } else if (scrollView.contentOffset.x == 0) {
        scrollView.contentOffset = CGPointMake(self.scrollViewWidth * self.imageCount, scrollView.contentOffset.y);
    }
}

@end
