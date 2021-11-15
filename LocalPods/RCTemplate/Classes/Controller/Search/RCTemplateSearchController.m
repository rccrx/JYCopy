//
//  RCTemplateSearchController.m
//  RCTemplate
//
//  Created by crx on 2021/11/15.
//

#import "RCTemplateSearchController.h"
#import "RCTemplateSearchTextField.h"
#import "RCTemplateSearchMainController.h"
#import "RCTemplateSearchSuggestionController.h"
#import "RCTemplateSearchResultController.h"

@interface RCTemplateSearchController () <RCTemplateSearchSuggestionControllerDelegate, RCSearchTextFieldDelegate>

@property (nonatomic, strong) RCTemplateSearchTextField *searchTF;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) RCTemplateSearchMainController *mainVC;
@property (nonatomic, strong) RCTemplateSearchSuggestionController *suggestionVC;
@property (nonatomic, strong) RCTemplateSearchResultController *resultVC;

@end

@implementation RCTemplateSearchController

#pragma mark - Life Cycle & Override
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self addSearchMainController];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.searchTF becomeFirstResponder];
}

#pragma mark - UI
- (void)setupUI {
    self.view.backgroundColor = UIColor.rte_backgroundColor;
    
    UIView *searchBar = [[UIView alloc] init];
    [self.view addSubview:searchBar];
    CGFloat searchBarHeight = 30;
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(@30);
        make.height.equalTo(@(searchBarHeight));
    }];
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    self.cancelBtn.titleLabel.font = Font_PFSC_R(15);
    [searchBar addSubview:self.cancelBtn];
    CGFloat cancelRight = 15;
    CGFloat cancelWidth = 31;
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-cancelRight));
        make.top.bottom.equalTo(searchBar);
        make.width.equalTo(@(cancelWidth));
    }];
    [self.cancelBtn addTarget:self action:@selector(cancelButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.searchTF = [[RCTemplateSearchTextField alloc] init];
    self.searchTF.placeholder = self.placeholder;
    self.searchTF.font = Font_PFSC_R(15);
    [self.searchTF addTarget:self action:@selector(searchTFEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.searchTF addTarget:self action:@selector(searchTFEditingDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
    self.searchTF.delegate = self;
    [searchBar addSubview:self.searchTF];
    CGFloat searchTFLeft = 15;
    CGFloat searchToCancelMargin = 15;
    CGFloat searchTFHeight = searchBarHeight;
    CGFloat searchTFWidth = ScreenWidth - cancelRight - cancelWidth - searchToCancelMargin - searchTFLeft;
    [self.searchTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(searchTFLeft));
        make.top.bottom.equalTo(searchBar);
        make.width.equalTo(@(searchTFWidth));
    }];
    [self.searchTF setupViewRectWithSearchTFWidth:searchTFWidth searchTFheight:searchTFHeight];
}

#pragma mark - Child ViewController
- (void)addSearchMainController {
    _mainVC = [RCTemplateSearchMainController new];
    [self addChildViewControllerAndItsView:self.mainVC];
}

- (void)addChildViewControllerAndItsView:(UIViewController *)vc {
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(60);
    }];
    [vc didMoveToParentViewController:self];
}

/** 显示其中一个子视图控制器，其他子视图控制器的视图隐藏 */
- (void)showJustOneChildViewController:(UIViewController *)vc {
    if (vc == self.mainVC) {
        self.mainVC.view.hidden = NO;
        _suggestionVC.view.hidden = YES; // 如果_suggestionVC已经创建则隐藏
        _resultVC.view.hidden = YES; // 如果_resultVC已经创建则隐藏
    } else if (vc == _suggestionVC) {
        self.mainVC.view.hidden = YES;
        _suggestionVC.view.hidden = NO;
        _resultVC.view.hidden = YES;
    } else if (vc == _resultVC) {
        self.mainVC.view.hidden = YES;
        _suggestionVC.view.hidden = YES;
        _resultVC.view.hidden = NO;
    }
}

#pragma mark - Lazy
- (RCTemplateSearchSuggestionController *)suggestionVC {
    if (!_suggestionVC) {
        _suggestionVC = [RCTemplateSearchSuggestionController new];
        _suggestionVC.delegate = self;
        [self addChildViewControllerAndItsView:_suggestionVC];
    }
    return _suggestionVC;
}

- (RCTemplateSearchResultController *)resultVC {
    if (!_resultVC) {
        _resultVC = [RCTemplateSearchResultController new];
        [self addChildViewControllerAndItsView:_resultVC];
    }
    return _resultVC;
}

#pragma mark - Action
- (void)cancelButtonDidClicked:(UIButton *)button {
    if (_resultVC && !_resultVC.view.hidden) {
        self.searchTF.text = nil;
        [self showJustOneChildViewController:self.mainVC];
    } else {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

- (void)searchTFEditingChanged:(RCSearchTextField *)tf {
    if (tf.text.length > 0) {
        [self showJustOneChildViewController:self.suggestionVC];
    }
}

- (void)searchTFEditingDidBegin:(RCSearchTextField *)tf {
    if (tf.text.length > 0) {
        [self showJustOneChildViewController:self.suggestionVC];
    }
}

#pragma mark - Delegate

#pragma mark RCTemplateSearchSuggestionControllerDelegate
- (void)searchSuggestionController:(RCTemplateSearchSuggestionController *)searchSuggestionController didSelectKeyword:(NSString *)keyword {
    [self.searchTF resignFirstResponder];
    [self showJustOneChildViewController:self.resultVC];
}

#pragma mark RCSearchTextFieldDelegate
- (void)searchTextFieldClearButtonClicked:(RCSearchTextField *)searchTextField {
    [self.searchTF resignFirstResponder];
    [self showJustOneChildViewController:self.mainVC];
}

@end
