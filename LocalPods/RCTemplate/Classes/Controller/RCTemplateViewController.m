//
//  RCTemplateViewController.m
//  RCTemplate
//
//  Created by crx on 2021/11/12.
//

#import "RCTemplateViewController.h"
#import "RCTemplateSearchTextField.h"
#import "RCTemplateSearchController.h"

@interface RCTemplateViewController ()
@property (nonatomic, strong) RCTemplateSearchTextField *searchTF;
@end

@implementation RCTemplateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.rte_color181818;
    
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
}

- (void)searchTextFieldDidTapped:(UITapGestureRecognizer *)tap {
    RCTemplateSearchController *vc = [[RCTemplateSearchController alloc] init];
    vc.placeholder = self.searchTF.placeholder;
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:NO completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

@end
