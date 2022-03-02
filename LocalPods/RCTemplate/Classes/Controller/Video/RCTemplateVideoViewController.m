//
//  RCTemplateVideoViewController.m
//  RCTemplate
//
//  Created by crx on 2022/2/19.
//

#import "RCTemplateVideoViewController.h"
#import "RCTemplateVideoTableViewCell.h"

@interface RCTemplateVideoViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *backButton;
@end

@implementation RCTemplateVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    self.view.backgroundColor = UIColor.blackColor;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:RCTemplateVideoTableViewCell.class forCellReuseIdentifier:NSStringFromClass(RCTemplateVideoTableViewCell.class)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.pagingEnabled = YES;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    
    self.backButton = [UIButton rut_buttonWithImage:[UIImage rte_imageNamedInTemplateBundle:@"video_back"] target:self action:@selector(backButtonDidClicked:)];
    [self.view addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.top.equalTo(self.view).offset(20);
        make.width.height.equalTo(@20);
    }];
}

#pragma mark - Action
- (void)backButtonDidClicked:(UIButton *)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ScreenHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RCTemplateVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(RCTemplateVideoTableViewCell.class)];
    cell.backgroundColor = RGB_DEC(105, 255, (indexPath.row * 100) % 255);
    cell.data = self.data;
    return cell;
}

@end
