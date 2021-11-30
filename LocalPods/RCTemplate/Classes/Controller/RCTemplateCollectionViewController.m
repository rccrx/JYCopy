//
//  RCTemplateCollectionViewController.m
//  RCTemplate
//
//  Created by crx on 2021/11/24.
//

#import "RCTemplateCollectionViewController.h"
#import "RCTemplateCollectionViewCell.h"
#import "RCCollectionViewAdaptiveHeightLayout.h"
#import "MJRefresh.h"

@interface RCTemplateCollectionViewController () <UICollectionViewDataSource, RCCollectionViewDelegateAdaptiveHeightLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *cvDataSource;
@end

@implementation RCTemplateCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cvDataSource = [NSMutableArray array];
    [self.cvDataSource addObjectsFromArray:@[@"一", @"二", @"三", @"四", @"五", @"六", @"七", @"八", @"九"]];
    
    RCCollectionViewAdaptiveHeightLayout *layout = [[RCCollectionViewAdaptiveHeightLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
    layout.lineSpacing = 20;
    layout.interitemSpacing = 10;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(150, 100);
//    flowLayout.sectionHeadersPinToVisibleBounds = YES;
//    flowLayout.headerReferenceSize = CGSizeMake(300, 50);
//    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];

    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = UIColor.greenColor;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:RCTemplateCollectionViewCell.class forCellWithReuseIdentifier:NSStringFromClass(RCTemplateCollectionViewCell.class)];
    [self.collectionView registerClass:UICollectionViewCell.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(UILabel.class)];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
//        make.left.top.equalTo(self.view);
//        make.width.equalTo(@250);
//        make.height.equalTo(@200);
    }];
    
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        NSLog(@"133");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.cvDataSource addObjectsFromArray:@[@"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九"]];
            
            [self.collectionView reloadData];
//            NSMutableArray *marr = [NSMutableArray array];
//            for (int i = 0; i < 9; i++) {
//                [marr addObject:[NSIndexPath indexPathForItem:i+0 inSection:0]];
//            }
//            [self.collectionView reloadItemsAtIndexPaths:marr.copy];
//            [self.collectionView insertItemsAtIndexPaths:marr.copy];
            [self.collectionView.mj_footer endRefreshing];
        });
    }];
    
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:[NSString stringWithFormat:@"随机：%d", arc4random_uniform(1000)] forState:UIControlStateNormal];
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = UIColor.redColor.CGColor;
    [btn addTarget:self action:@selector(onClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(self.view);
            make.height.width.equalTo(@100);
    }];
}

- (void)onClicked {
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource & RCCollectionViewDelegateAdaptiveHeightLayout

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.cvDataSource.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RCTemplateCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(RCTemplateCollectionViewCell.class) forIndexPath:indexPath];
    UILabel *label = [cell viewWithTag:123];
    if (!label) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        label.backgroundColor = UIColor.rte_color8C8C8C;
        label.textColor = UIColor.whiteColor;
        [cell addSubview:label];
    }
//    cell.layer.borderWidth = 3;
    cell.backgroundColor = UIColor.cyanColor;
    label.text = [NSString stringWithFormat:@"(%ld, %ld): %@", indexPath.section, indexPath.row, self.cvDataSource[indexPath.row]];
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item % 2) {
        return 200;
    } else {
        return 120;
    }
//    return (indexPath.item % 5 + 1) * 50;
//    if (indexPath.item == 1) {
//        return 800;
//    } else {
//        return 240;
//    }
}

@end
