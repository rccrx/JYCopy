//
//  RCTemplateCollectionViewController.m
//  RCTemplate
//
//  Created by crx on 2021/11/24.
//

#import "RCTemplateCollectionViewController.h"
#import "RCTemplateCollectionViewCell.h"
#import "RCCollectionViewAdaptiveHeightLayout.h"
#import "RCTemplateCollectionViewModel.h"
#import "RCRefreshCAHeader.h"
#import "RCRefreshAutoCAFooter.h"
#import "RCTemplateCollectionEmptyView.h"
#import "RCTemplateCollectionRequestErrorView.h"
#import "RCTemplateVideoViewController.h"
#import "RCTemplateVideoPresentationController.h"

@interface RCTemplateCollectionViewController () <UICollectionViewDataSource, RCCollectionViewDelegateAdaptiveHeightLayout, UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) RCTemplateCollectionEmptyView *emptyView;
@property (nonatomic, strong) RCTemplateCollectionRequestErrorView *requestErrorView;
@end

@implementation RCTemplateCollectionViewController

#pragma mark - Life Cycle & UI
- (instancetype)init {
    if (self = [super init]) {
        _viewModel = [RCTemplateCollectionViewModel new];
    }
    return self;
}

- (void)dealloc {
    [self removeObservers];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self addObservers];
    [self requestData];
}

- (void)setupUI {
    __weak typeof(self) weakSelf = self;
    
    // collectionView
    RCCollectionViewAdaptiveHeightLayout *layout = [[RCCollectionViewAdaptiveHeightLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
    layout.lineSpacing = 20;
    layout.interitemSpacing = 10;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = UIColor.rte_backgroundColor;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:RCTemplateCollectionViewCell.class forCellWithReuseIdentifier:NSStringFromClass(RCTemplateCollectionViewCell.class)];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    
    self.collectionView.mj_header = [RCRefreshCAHeader headerWithRefreshingBlock:^{
        [weakSelf.viewModel getTemplatesForCurrentCollectionId];
    }];
    
    
    // emptyView
    self.emptyView = [RCTemplateCollectionEmptyView new];
    [self.view addSubview:self.emptyView];
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    
    
    // requestErrorView
    self.requestErrorView = [RCTemplateCollectionRequestErrorView new];
    self.requestErrorView.tapAction = ^{
        [weakSelf.viewModel getTemplatesForCurrentCollectionId];
    };
    [self.view addSubview:self.requestErrorView];
    [self.requestErrorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    
    
    [self showViewAndHideOthers:self.collectionView];
}

#pragma mark - Data
- (void)requestData {
    [self.viewModel getTemplatesForCurrentCollectionId];
}

#pragma mark - Private
/** ??????collectionView???emptyView???requestErrorView */
- (void)showViewAndHideOthers:(UIView *)view {
    if (view == self.collectionView) {
        self.collectionView.hidden = NO;
        self.emptyView.hidden = YES;
        self.requestErrorView.hidden = YES;
    } else if (view == self.emptyView) {
        self.collectionView.hidden = YES;
        self.emptyView.hidden = NO;
        self.requestErrorView.hidden = YES;
    } else if (view == self.requestErrorView) {
        self.collectionView.hidden = YES;
        self.emptyView.hidden = YES;
        self.requestErrorView.hidden = NO;
    }
}

#pragma mark - Observer
- (void)addObservers {
    [self.viewModel addObserver:self forKeyPath:@"templates" options:NSKeyValueObservingOptionNew context:nil];
    [self.viewModel addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeObservers {
    [self.viewModel removeObserver:self forKeyPath:@"templates" context:nil];
    [self.viewModel removeObserver:self forKeyPath:@"state" context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (object != self.viewModel) {
        return;
    }
    
    if ([keyPath isEqualToString:@"templates"]) {
        if (self.viewModel.templates.count > 0) {
            [self showViewAndHideOthers:self.collectionView];
        }
        [self.collectionView reloadData];
        
    } else if ([keyPath isEqualToString:@"state"]) {
        switch (self.viewModel.state) {
            case RCTemplatesRequestStateGetTemplatesStarted:
            {
                if (self.viewModel.templates.count == 0) { // ???????????? ??? ??????requestErrorView
                    self.requestErrorView.hidden = YES;
                    [MBProgressHUD showLoadingHUDAddedTo:self.view animated:YES];
                }
                break;
            }
            case RCTemplatesRequestStateGetTemplatesEndedSucceedHasMore:
            case RCTemplatesRequestStateGetTemplatesEndedSucceedNoMore:
            {
                [self.collectionView.mj_header endRefreshing];
                [MBProgressHUD hideLoadingHUDForView:self.view animated:NO];
                if (self.viewModel.state == RCTemplatesRequestStateGetTemplatesEndedSucceedNoMore) {
                    self.collectionView.mj_footer = nil;
                    if (self.viewModel.templates.count == 0) {
                        [self showViewAndHideOthers:self.emptyView];
                    }
                } else if (!self.collectionView.mj_footer) {
                    __weak typeof(self) weakSelf = self;
                    self.collectionView.mj_footer = [RCRefreshAutoCAFooter footerWithRefreshingBlock:^{
                        [weakSelf.viewModel loadMoreTemplates];
                    }];
                    [(RCRefreshAutoCAFooter *)self.collectionView.mj_footer setTriggerAutomaticallyRefreshPercent:0.1];
                }
                break;
            }
            case RCTemplatesRequestStateGetTemplatesEndedFailed:
            {
                NSLog(@"RCTemplatesRequestStateGetTemplatesEndedFailed: error=%@", self.viewModel.error);
                [self.collectionView.mj_header endRefreshing];
                [MBProgressHUD hideLoadingHUDForView:self.view animated:NO];
                if (self.viewModel.templates.count == 0) {
                    [self showViewAndHideOthers:self.requestErrorView];
                } else {
                    [MBProgressHUD showAutohideTextHUDAddedTo:self.view.window animated:YES text:@"????????????????????????"];
                }
                break;
            }
            case RCTemplatesRequestStateLoadMoreTemplatesEndedSucceedHasMore:
            case RCTemplatesRequestStateLoadMoreTemplatesEndedSucceedNoMore:
            {
                if (self.viewModel.state == RCTemplatesRequestStateLoadMoreTemplatesEndedSucceedNoMore) {
                    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                } else {
                    [self.collectionView.mj_footer endRefreshing];
                }
                break;
            }
            case RCTemplatesRequestStateLoadMoreTemplatesEndedFailed:
            {
                NSLog(@"RCTemplatesRequestStateLoadMoreTemplatesEndedFailed: error=%@", self.viewModel.error);
                [(RCRefreshAutoCAFooter *)self.collectionView.mj_footer endRefreshingWithDataFailed];
                [MBProgressHUD showAutohideTextHUDAddedTo:self.view.window animated:YES text:@"????????????????????????"];
                break;
            }
                
            default:
                break;
        }
    }
}

#pragma mark - UICollectionViewDataSource & RCCollectionViewDelegateAdaptiveHeightLayout & UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewModel.templates.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RCTemplateCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(RCTemplateCollectionViewCell.class) forIndexPath:indexPath];
    cell.data = self.viewModel.templates[indexPath.item];
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(RCCollectionViewAdaptiveHeightLayout *)collectionViewLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [RCTemplateCollectionViewCell getCellHeightWithData:self.viewModel.templates[indexPath.item] cellWidth:collectionViewLayout.itemWidth];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    RCTemplateVideoViewController *vc = [RCTemplateVideoViewController new];
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.transitioningDelegate = self;
    vc.sourceController = self;
    
    [self.viewModel recordSelectedIndex:indexPath.item];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    RCTemplateVideoPresentationController *presentationCtr = [[RCTemplateVideoPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    presentationCtr.sourceController = self;
    return presentationCtr;
}

#pragma mark - Public
- (void)scrollToSelectedItemIfNeeded {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:[self.viewModel getLastRecordedSelectedIndex] inSection:0];
    if (![self.collectionView.indexPathsForVisibleItems containsObject:indexPath]) {
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
    }
}

- (CGRect)getSelectedItemCoverFrame {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:[self.viewModel getLastRecordedSelectedIndex] inSection:0];
    RCTemplateCollectionViewCell *cell = (RCTemplateCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath]; // iOS15????????????cell???????????????cellForItemAtIndexPath??????nil
    return [cell convertRect:cell.coverImageView.frame toView:[UIApplication sharedApplication].keyWindow]; // toView????????????nil??????????????????cell???origin???0????????????????????????????????????
}

- (UIImage *)getSelectedItemCoverImage {
    RCTemplateCollectionViewCell *cell = (RCTemplateCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:[self.viewModel getLastRecordedSelectedIndex] inSection:0]];
    return cell.coverImageView.image;
}

@end
