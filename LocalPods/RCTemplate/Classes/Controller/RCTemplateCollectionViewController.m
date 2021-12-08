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

@interface RCTemplateCollectionViewController () <UICollectionViewDataSource, RCCollectionViewDelegateAdaptiveHeightLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
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
}

#pragma mark - Data
- (void)requestData {
    [self.viewModel requestFirstPageTemplates];
}

#pragma mark - Observer
- (void)addObservers {
    [self.viewModel addObserver:self forKeyPath:@"templates" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeObservers {
    [self.viewModel removeObserver:self forKeyPath:@"templates" context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"keypath=%@, obj=%@, chage=%@, tmplay=%@", keyPath, object, change, self.viewModel.templates);
}

#pragma mark - UICollectionViewDataSource & RCCollectionViewDelegateAdaptiveHeightLayout
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

@end
