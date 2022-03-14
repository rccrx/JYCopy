//
//  RCTemplateViewController.m
//  RCTemplate
//
//  Created by crx on 2021/11/12.
//

#import "RCTemplateViewController.h"
#import "RCTemplateSearchTextField.h"
#import "RCTemplateSearchController.h"
#import "RCTemplateCarouselView.h"
#import "RCScrollTabBar.h"
#import "RCTemplateCollectionViewController.h"
#import "RCTemplateCollectionViewModel.h"

@interface RCTemplateViewController () <RCScrollTabBarDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) RCTemplateSearchTextField *searchTF;
@property (nonatomic, strong) RCTemplateCarouselView *carouselView;
@property (nonatomic, strong) RCScrollTabBar *scrollTabBar;
@property (nonatomic, strong) UIScrollView *templateScrollView;

/** 存储显示在templateScrollView中的子视图控制器，以index为key */
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, RCTemplateCollectionViewController *> *childVCDict;
@end

@implementation RCTemplateViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark - Data
- (void)setupData {
    self.childVCDict = [ NSMutableDictionary dictionary];
}

#pragma mark - UI
- (void)setupUI {
    self.view.backgroundColor = UIColor.rte_backgroundColor;
    
    self.searchTF = [[RCTemplateSearchTextField alloc] init];
    self.searchTF.placeholder = @"日常碎片记录";
    [self.view addSubview:self.searchTF];
    CGFloat searchTFHeight = 30;
    CGFloat searchTFWidth = 230;
    [self.searchTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(@30);
        make.width.equalTo(@(searchTFWidth));
        make.height.equalTo(@(searchTFHeight));
    }];
    [self.searchTF setupViewRectWithSearchTFWidth:searchTFWidth searchTFheight:searchTFHeight];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchTextFieldDidTapped:)];
    [self.searchTF addGestureRecognizer:tap];
    
    
    CGFloat carouselWidth = ScreenWidth;
    CGFloat carouselHeight = 80;
    self.carouselView = [[RCTemplateCarouselView alloc] initWithImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 15) viewWidth:carouselWidth viewHeight:carouselHeight];
    self.carouselView.enableAutoslide = YES;
    [self.view addSubview:self.carouselView];
    [self.carouselView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.width.equalTo(@(carouselWidth));
        make.top.equalTo(self.searchTF.mas_bottom).offset(10);
        make.height.equalTo(@(carouselHeight));
    }];
    self.carouselView.images = @[[UIImage rte_imageNamedInTemplateBundle:@"search"], [UIImage rte_imageNamedInTemplateBundle:@"clear"], [UIImage rte_imageNamedInTemplateBundle:@"arrow_right"]];
    
    CGFloat barHeight = 50;
    self.scrollTabBar = [[RCScrollTabBar alloc] init];
    NSArray *titles = @[@"推荐", @"卡点", @"日常碎片", @"玩法", @"旅行", @"纪念日", @"Vlog", @"萌娃"];
    [self.scrollTabBar setItemTitles:titles barHeight:barHeight];
    self.scrollTabBar.delegate = self;
    [self.view addSubview:self.scrollTabBar];
    [self.scrollTabBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(barHeight));
        make.top.equalTo(self.carouselView.mas_bottom).offset(5);
    }];
    
    CGFloat templateSVWidth = ScreenWidth;
    self.templateScrollView = [[UIScrollView alloc] init];
    self.templateScrollView.delegate = self;
    self.templateScrollView.pagingEnabled = YES;
    self.templateScrollView.contentSize = CGSizeMake(templateSVWidth * titles.count, 1);
    self.templateScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.templateScrollView];
    [self.templateScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.width.equalTo(@(templateSVWidth));
        make.top.equalTo(self.scrollTabBar.mas_bottom);
        make.bottom.equalTo(self.view);
    }];
    
    [self addChildViewControllerIfNeededWithIndex:0];
}

#pragma mark - Action
- (void)searchTextFieldDidTapped:(UITapGestureRecognizer *)tap {
    RCTemplateSearchController *vc = [[RCTemplateSearchController alloc] init];
    vc.placeholder = self.searchTF.placeholder;
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:NO completion:nil];
}

#pragma mark - Private
/** 如果这个index的vc已经添加则不用再添加 */
- (void)addChildViewControllerIfNeededWithIndex:(NSUInteger)index {
    RCTemplateCollectionViewController *vc = self.childVCDict[@(index)];
    if (vc) {
        return;
    }
    
    vc = [RCTemplateCollectionViewController new];
    vc.viewModel.collectionId = NSSTRING_COLLECTION_ID_1;
    [self addChildViewController:vc];
    CGFloat templateSVWidth = CGRectGetWidth(self.templateScrollView.frame);
    CGFloat templateSVHeight = CGRectGetHeight(self.templateScrollView.frame);
    vc.view.frame = CGRectMake(templateSVWidth * index, 0, templateSVWidth, templateSVHeight);
    [self.templateScrollView addSubview:vc.view];
    [vc didMoveToParentViewController:self];
    
    self.childVCDict[@(index)] = vc;
}

#pragma mark - RCScrollTabBarDelegate
- (void)scrollTabBar:(RCScrollTabBar *)scrollTabBar didSelectItem:(NSUInteger)selectedIndex {
    CGFloat templateSVWidth = CGRectGetWidth(self.templateScrollView.frame);
    [self.templateScrollView scrollRectToVisible:CGRectMake(selectedIndex * templateSVWidth, 0, templateSVWidth, 1) animated:NO];
    [self addChildViewControllerIfNeededWithIndex:selectedIndex];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 处理手势滑动的情况（不能处理点击tab的情况，点击tab之后调用这个协议方法时currentIdx已经是目标idx）
    CGFloat templateSVWidth = CGRectGetWidth(self.templateScrollView.frame);
    NSUInteger currentIdx = self.scrollTabBar.selectedIndex;
    if (scrollView.contentOffset.x > templateSVWidth * currentIdx) {
        NSUInteger nextIdx = currentIdx + 1;
        if (nextIdx >= self.scrollTabBar.tabCount) {
            return;
        }
        [self addChildViewControllerIfNeededWithIndex:nextIdx]; // 如果视图已经添加则调用这个方法相当于空操作
        if (scrollView.contentOffset.x > templateSVWidth * (currentIdx + 0.9)) {
            [self.scrollTabBar setSelectedIndex:nextIdx animated:YES];
        }
    } else if (scrollView.contentOffset.x < templateSVWidth * currentIdx) {
        NSInteger nextIdx = currentIdx - 1;
        if (nextIdx < 0) {
            return;
        }
        [self addChildViewControllerIfNeededWithIndex:nextIdx];
        if (scrollView.contentOffset.x < templateSVWidth * (currentIdx - 0.9)) {
            [self.scrollTabBar setSelectedIndex:nextIdx animated:YES];
        }
    }
}

@end
