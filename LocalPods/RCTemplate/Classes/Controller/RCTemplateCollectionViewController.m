//
//  RCTemplateCollectionViewController.m
//  RCTemplate
//
//  Created by crx on 2021/11/24.
//

#import "RCTemplateCollectionViewController.h"

@interface RCTemplateCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *cvDataSource;
@property (nonatomic, assign) NSUInteger sectionCount;
@end

@implementation RCTemplateCollectionViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%@: %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%@: %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"%@: %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@: %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
    
    self.sectionCount = 1;
//    self.sectionCount = 2;
    
    self.cvDataSource = [NSMutableArray array];
    [self.cvDataSource addObjectsFromArray:@[@"一", @"二", @"三", @"四", @"五", @"六", @"七", @"八", @"九"]];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(150, 100);
//    flowLayout.sectionHeadersPinToVisibleBounds = YES;
    flowLayout.headerReferenceSize = CGSizeMake(300, 50);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
//    self.collectionView.backgroundColor = RGB_DEC(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256));
    self.collectionView.backgroundColor = UIColor.greenColor;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:NSStringFromClass(UICollectionViewCell.class)];
    [self.collectionView registerClass:UICollectionViewCell.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(UILabel.class)];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = UIColor.greenColor;
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
//        [self.view addSubview:self.tableView];
//        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.top.bottom.equalTo(self.view);
//        }];
    
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
//    [self.cvDataSource addObject:@"十"];
//    [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]];
//    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationLeft | UITableViewRowAnimationMiddle];
    
//    self.sectionCount++;
//////    [self.collectionView reloadData];
    NSMutableIndexSet *is = [NSMutableIndexSet indexSetWithIndex:0];
//    [is addIndex:1];
////    [is addIndex:2];
////    [self.collectionView insertSections:is];
//////    [self.collectionView reloadSections:is];
//    [self.tableView insertSections:is withRowAnimation:UITableViewRowAnimationLeft];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//    a = !a;
//        [self.tableView reloadSections:is withRowAnimation:UITableViewRowAnimationLeft];
//    });
    
    UILabel *view = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
    view.backgroundColor = UIColor.blueColor;
    self.tableView.tableHeaderView = view;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    
//    [self.tableView performBatchUpdates:^{
//    [self.tableView beginUpdates];
        UILabel *view = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
        view.backgroundColor = UIColor.blueColor;
        view.text = @"hleoo";
        self.tableView.tableHeaderView = view;
//    [self.tableView endUpdates];
//    } completion:nil];
    });
}

#pragma mark - UICollectionViewDataSource & UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sectionCount;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0 && self.sectionCount > 1) {
        return 2;
    }
    return self.cvDataSource.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(UICollectionViewCell.class) forIndexPath:indexPath];
    UILabel *label = [cell viewWithTag:123];
    if (!label) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        label.backgroundColor = UIColor.rte_color8C8C8C;
        label.textColor = UIColor.whiteColor;
        [cell addSubview:label];
    }
//    cell.layer.borderWidth = 3;
    cell.backgroundColor = UIColor.rte_backgroundColor;
    label.text = [NSString stringWithFormat:@"(%ld, %ld): %@", indexPath.section, indexPath.row, self.cvDataSource[indexPath.row]];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass(UILabel.class) forIndexPath:indexPath];
    view.backgroundColor = UIColor.rte_backgroundColor;
    UILabel *label = [view viewWithTag:123];
    if (!label) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
//        label.backgroundColor = UIColor.lightGrayColor;
        label.textColor = UIColor.whiteColor;
        [view addSubview:label];
    }
    label.text = [NSString stringWithFormat:@"header: indexPath=(%ld, %ld)", indexPath.section, indexPath.row];
    return view;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
//    if (section == 0 && self.sectionCount > 1) {
        return CGSizeZero;
//    } else {
//        return CGSizeMake(300, 50);
//    }
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 && self.sectionCount > 1) {
        return 1;
    }
    return self.cvDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class)];
    cell.textLabel.text = [NSString stringWithFormat:@"(%ld, %ld): %@", indexPath.section, indexPath.row, self.cvDataSource[indexPath.row]];
    cell.backgroundColor = UIColor.redColor;
    cell.textLabel.textColor = UIColor.whiteColor;
    cell.layer.borderWidth = 3;
    return cell;
}
BOOL a = YES;

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && self.sectionCount > 1) {
        if (!a) {
            return 80;
        } else {
            return 40;
        }
    }
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0 && self.sectionCount > 1) {
        return 0;
    } else {
        return 50;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = UIColor.rte_backgroundColor;
    UILabel *label = [view viewWithTag:123];
    if (!label) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
//        label.backgroundColor = UIColor.lightGrayColor;
        label.textColor = UIColor.whiteColor;
        [view addSubview:label];
    }
    label.text = [NSString stringWithFormat:@"header: section=%ld", section];
    return view;
}


@end
