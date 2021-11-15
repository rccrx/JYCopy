//
//  RCTemplateSearchSuggestionController.m
//  RCTemplate
//
//  Created by crx on 2021/11/15.
//

#import "RCTemplateSearchSuggestionController.h"

@interface RCTemplateSearchSuggestionController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation RCTemplateSearchSuggestionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.rte_backgroundColor;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 300) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    cell.backgroundColor = UIColor.rte_backgroundColor;
    cell.textLabel.textColor = UIColor.whiteColor;
    cell.textLabel.text = [NSString stringWithFormat:@"随机数字：%d", arc4random_uniform(1000)];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(searchSuggestionController:didSelectKeyword:)]) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [self.delegate searchSuggestionController:self didSelectKeyword:cell.textLabel.text];
    }
}

@end
