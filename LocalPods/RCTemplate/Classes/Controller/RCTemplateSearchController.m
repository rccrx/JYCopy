//
//  RCTemplateSearchController.m
//  RCTemplate
//
//  Created by crx on 2021/11/15.
//

#import "RCTemplateSearchController.h"
#import "RCSearchBar.h"
#import "RCTemplateSearchTextField.h"

@interface RCTemplateSearchController ()
@property (nonatomic, strong) RCSearchBar *searchBar;
@end

@implementation RCTemplateSearchController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    self.view.backgroundColor = UIColor.rte_color181818;
    
    self.searchBar = [[RCSearchBar alloc] init];
    [self.view addSubview:self.searchBar];
    CGFloat searchBarHeight = 30;
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(@30);
        make.height.equalTo(@(searchBarHeight));
    }];
    
    RCTemplateSearchTextField *searchTF = [[RCTemplateSearchTextField alloc] init];
    searchTF.placeholder = self.placeholder;
    self.searchBar.searchTextField = searchTF;
    CGFloat searchTFHeight = searchBarHeight;
    CGFloat searchTFWidth = 300;
    [searchTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.bottom.equalTo(self.searchBar);
        make.width.equalTo(@(searchTFWidth));
    }];
    [searchTF setupViewRectWithSearchTFWidth:searchTFWidth searchTFheight:searchTFHeight];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = Font_PFSC_R(15);
    self.searchBar.cancelButton = cancelBtn;
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-15));
        make.top.bottom.equalTo(self.searchBar);
        make.width.equalTo(@(31));
    }];
    [cancelBtn addTarget:self action:@selector(cancelButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Action
- (void)cancelButtonDidClicked:(UIButton *)button {
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
