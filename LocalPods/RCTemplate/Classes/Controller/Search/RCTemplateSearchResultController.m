//
//  RCTemplateSearchResultController.m
//  RCTemplate
//
//  Created by crx on 2021/11/15.
//

#import "RCTemplateSearchResultController.h"

@interface RCTemplateSearchResultController ()

@end

@implementation RCTemplateSearchResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.rte_backgroundColor;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(75, 25, 99, 17)];
    label.text = @"模板";
    label.textColor = UIColor.whiteColor;
    [self.view addSubview:label];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(199, 25, 99, 17)];
    label2.text = @"用户";
    label2.textColor = [UIColor colorWithWhite:0.7 alpha:1];
    [self.view addSubview:label2];
}

@end
