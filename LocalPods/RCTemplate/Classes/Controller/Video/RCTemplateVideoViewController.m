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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 由于视频的播放启动由scrollViewDidEndDecelerating控制，而第一个显示的cell不调用这个方法，所以使用另外的方式启动第一个显示cell的播放
    if (self.tableView.visibleCells.count > 0) { // 正常情况下是1
        RCTemplateVideoTableViewCell *cell = self.tableView.visibleCells[0];
        [cell playVideo];
    }
}

- (void)setupUI {
    self.view.backgroundColor = UIColor.blackColor;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = UIColor.blackColor;
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:RCTemplateVideoTableViewCell.class forCellReuseIdentifier:NSStringFromClass(RCTemplateVideoTableViewCell.class)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.pagingEnabled = YES;
    self.tableView.estimatedRowHeight = ScreenHeight; // 避免一开始显示时调用过多的cellForRowAtIndexPath
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
    return self.datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ScreenHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RCTemplateVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(RCTemplateVideoTableViewCell.class)];
    cell.data = self.datas[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    RCTemplateVideoTableViewCell *tvCell = (RCTemplateVideoTableViewCell *)cell;
    [tvCell pauseVideo];
}

// 刚显示页面时不会调用这个协议方法，所以第一个显示的cell使用另外的方法启动播放
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.tableView.visibleCells.count > 0) { // 正常情况下是1
        RCTemplateVideoTableViewCell *cell = self.tableView.visibleCells[0];
        [cell playVideo];
    }
}

@end
