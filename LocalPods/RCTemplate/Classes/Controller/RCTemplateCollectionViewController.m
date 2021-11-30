//
//  RCTemplateCollectionViewController.m
//  RCTemplate
//
//  Created by crx on 2021/11/24.
//

#import "RCTemplateCollectionViewController.h"
#import "RCTemplateCollectionViewCell.h"
#import "RCCollectionViewAdaptiveHeightLayout.h"

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
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = UIColor.greenColor;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:RCTemplateCollectionViewCell.class forCellWithReuseIdentifier:NSStringFromClass(RCTemplateCollectionViewCell.class)];
    [self.collectionView registerClass:UICollectionViewCell.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(UILabel.class)];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
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
    return (indexPath.item % 5 + 1) * 50;
}

@end
