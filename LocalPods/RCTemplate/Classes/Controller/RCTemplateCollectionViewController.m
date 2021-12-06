//
//  RCTemplateCollectionViewController.m
//  RCTemplate
//
//  Created by crx on 2021/11/24.
//

#import "RCTemplateCollectionViewController.h"
#import "RCTemplateCollectionViewCell.h"
#import "RCCollectionViewAdaptiveHeightLayout.h"
#import "RCTemplateModel.h"
#import "RCTemplateCollectionViewModel.h"

@interface RCTemplateCollectionViewController () <UICollectionViewDataSource, RCCollectionViewDelegateAdaptiveHeightLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray<RCTemplateModel *> *cvDataArray;
@end

@implementation RCTemplateCollectionViewController

#pragma mark - Life Cycle
- (instancetype)init {
    if (self = [super init]) {
        _viewModel = [RCTemplateCollectionViewModel new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeProperties];
    [self setupUI];
    [self requestData];
}

- (void)initializeProperties {
    self.cvDataArray = [NSMutableArray array];
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

- (void)requestData {
    for (int i = 0; i < 10; i++) {
        RCTemplateModel *model = [[RCTemplateModel alloc] init];
        if (arc4random_uniform(2)) {
            model.coverURL = @"https://img1.baidu.com/it/u=1995363239,4274347774&fm=26&fmt=auto";
        } else {
            model.coverURL = @"https://img2.baidu.com/it/u=781607565,66374776&fm=26&fmt=auto";
        }
        model.coverRatio = (arc4random_uniform(120) + 50) / 100.0;
        model.usageCount = 22;
        model.likeCount = 6;
        model.title = [NSString stringWithFormat:@"砸雪球变身: %d", i];
        model.subtitle = @"今日份美好 | 文字可更改#日常碎片#";
        model.avatarURL = @"https://img2.baidu.com/it/u=3989200917,112452247&fm=26&fmt=auto";
        model.nickname = @"Ahfjinga（手机摄影）";
        [self.cvDataArray addObject:model];
    }
    [self.collectionView reloadData];
    
    [self.viewModel requestTemplatesInCollection];
}

#pragma mark - UICollectionViewDataSource & RCCollectionViewDelegateAdaptiveHeightLayout
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.cvDataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RCTemplateCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(RCTemplateCollectionViewCell.class) forIndexPath:indexPath];
    cell.data = self.cvDataArray[indexPath.item];
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(RCCollectionViewAdaptiveHeightLayout *)collectionViewLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [RCTemplateCollectionViewCell getCellHeightWithData:self.cvDataArray[indexPath.item] cellWidth:collectionViewLayout.itemWidth];
}

@end
