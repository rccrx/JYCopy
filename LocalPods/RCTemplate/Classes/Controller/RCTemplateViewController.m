//
//  RCTemplateViewController.m
//  RCTemplate
//
//  Created by crx on 2021/11/12.
//

#import "RCTemplateViewController.h"

@interface RCTemplateViewController ()

@end

@implementation RCTemplateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.rte_color181818;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

@end
