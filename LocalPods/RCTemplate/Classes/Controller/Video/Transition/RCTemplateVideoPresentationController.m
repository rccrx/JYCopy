//
//  RCTemplateVideoPresentationController.m
//  RCTemplate
//
//  Created by crx on 2022/3/8.
//

#import "RCTemplateVideoPresentationController.h"
#import "RCTemplateCollectionViewController.h"

@interface RCTemplateVideoPresentationController ()
@property (nonatomic, strong) UIView *dimmingView;
@property (nonatomic, strong) UIImageView *coverImageView;
@end

@implementation RCTemplateVideoPresentationController

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController {
    if (self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController]) {
        self.dimmingView = [[UIView alloc] init];
        self.dimmingView.backgroundColor = UIColor.blackColor;
        
        self.coverImageView = [[UIImageView alloc] init];
        self.coverImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

// 这个方法重写返回YES，则状态栏的隐藏可以由presentedVC的prefersStatusBarHidden控制，但是，会导致即使presentedVC在调用dismissViewControllerAnimated之前调用了sourceController的scrollToSelectedItemIfNeeded，结果还是没有图片位置移动的动画
//- (BOOL)shouldRemovePresentersView {
//    return YES;
//}

- (void)presentationTransitionWillBegin {
    UIImage *coverImage = [self.sourceController getSelectedItemCoverImage];
    CGRect coverFrame = [self.sourceController getSelectedItemCoverFrame];
    
    self.dimmingView.frame = self.containerView.bounds;
    [self.containerView addSubview:self.dimmingView];
    [self.dimmingView addSubview:self.presentedViewController.view];
    
    self.coverImageView.image = coverImage;
    [self.containerView addSubview:self.coverImageView];
    
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    self.dimmingView.alpha = 0;
    self.coverImageView.frame = coverFrame;
    self.presentedViewController.view.hidden = YES;
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dimmingView.alpha = 1;
        self.coverImageView.frame = UIScreen.mainScreen.bounds;
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.presentedViewController.view.hidden = NO;
    }];
}

- (void)dismissalTransitionWillBegin {
    UIImage *coverImage = [self.sourceController getSelectedItemCoverImage];
    CGRect coverFrame = [self.sourceController getSelectedItemCoverFrame];
    self.coverImageView.image = coverImage;
    
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    self.dimmingView.alpha = 1;
    self.coverImageView.frame = UIScreen.mainScreen.bounds;
    self.presentedViewController.view.hidden = YES;
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dimmingView.alpha = 0;
        self.coverImageView.frame = coverFrame;
    } completion:nil];
}

@end
