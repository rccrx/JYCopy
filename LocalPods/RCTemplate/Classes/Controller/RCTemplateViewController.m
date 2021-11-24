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

@interface RCTemplateViewController () <RCScrollTabBarDelegate>
@property (nonatomic, strong) RCTemplateSearchTextField *searchTF;
@property (nonatomic, strong) RCTemplateCarouselView *carouselView;
@end

@implementation RCTemplateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
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
    RCScrollTabBar *scrollTabBar = [[RCScrollTabBar alloc] init];
    NSArray *titles = @[@"推荐", @"卡点", @"日常碎片", @"玩法", @"旅行", @"纪念日", @"Vlog", @"萌娃"];
    [scrollTabBar setItemTitles:titles barHeight:barHeight];
    scrollTabBar.delegate = self;
    [self.view addSubview:scrollTabBar];
    [scrollTabBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(barHeight));
        make.top.equalTo(self.view).offset(200);
    }];
    scrollTabBar.layer.borderWidth = 1;
}

#pragma mark - Action
- (void)searchTextFieldDidTapped:(UITapGestureRecognizer *)tap {
    RCTemplateSearchController *vc = [[RCTemplateSearchController alloc] init];
    vc.placeholder = self.searchTF.placeholder;
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:NO completion:nil];
}

#pragma mark - RCScrollTabBarDelegate
- (void)scrollTabBar:(RCScrollTabBar *)scrollTabBar didSelectItem:(NSUInteger)selectedIndex {
    NSLog(@"选中：%lu", selectedIndex);
}
@end
