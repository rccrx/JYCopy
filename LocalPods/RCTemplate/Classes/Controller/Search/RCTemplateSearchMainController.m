//
//  RCTemplateSearchMainController.m
//  RCTemplate
//
//  Created by crx on 2021/11/15.
//

#import "RCTemplateSearchMainController.h"

@interface RCTemplateSearchMainController ()

@end

@implementation RCTemplateSearchMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.rte_backgroundColor;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 35, 99, 17)];
    label.text = @"热搜";
    label.textColor = UIColor.whiteColor;
    [self.view addSubview:label];
}

@end
