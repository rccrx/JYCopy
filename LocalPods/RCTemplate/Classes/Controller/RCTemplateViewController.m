//
//  RCTemplateViewController.m
//  RCTemplate
//
//  Created by crx on 2021/11/12.
//

#import "RCTemplateViewController.h"
#import "RCSearchTextFiled.h"

@interface RCTemplateViewController ()

@end

@implementation RCTemplateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.rte_color181818;
    UIImage *searchIcon = [UIImage rte_imageNamedInTemplateBundle:@"search"];
    UIImage *clearIcon = [UIImage rte_imageNamedInTemplateBundle:@"clear"];
    RCSearchTextFiled *stf = [[RCSearchTextFiled alloc] initWithSearchIcon:searchIcon clearIcon:clearIcon];
    stf.customRightViewMode = RCTextFieldViewModeWhileHasText;
    stf.backgroundColor = UIColor.rte_color282828;
    stf.placeholder = @"一路";
    stf.layer.cornerRadius = 15;
    stf.tag = 1;
    [self.view addSubview:stf];
    CGFloat searchTFHeight = 30;
    CGFloat searchTFWidth = 230;
    [stf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(@30);
        make.width.equalTo(@(searchTFWidth));
        make.height.equalTo(@(searchTFHeight));
    }];
    
    CGFloat searchLeftMargin = 8;
    stf.leftViewRect = CGRectMake(searchLeftMargin, 0, searchIcon.size.width, searchTFHeight);
    
    CGFloat clearRightMargin = 10;
    CGFloat clearWidth = clearIcon.size.width;
    stf.rightViewRect = CGRectMake(searchTFWidth - clearWidth - clearRightMargin, 0, clearWidth, searchTFHeight);
    
    CGFloat editingToSearchMargin = 6;
    CGFloat editingToClearMargin = 12;
    CGFloat editingX = CGRectGetMaxX(stf.leftViewRect) + editingToSearchMargin;
    stf.editingRect = CGRectMake(editingX, 0, CGRectGetMinX(stf.rightViewRect) - editingToClearMargin - editingX, searchTFHeight);;
    stf.textRect = stf.editingRect;
    stf.placeholderRect = stf.editingRect;
    
    stf.tintColor = UIColor.rte_colorFCCF14;
    stf.textColor = UIColor.whiteColor;
    stf.font = Font_PFSC_R(14);
    stf.placeholderColor = UIColor.rte_color8C8C8C;
    
    UIButton *b = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [b addTarget:self action:@selector(ba) forControlEvents:UIControlEventTouchUpInside];
    b.backgroundColor = UIColor.redColor;
    [self.view addSubview:b];
}

- (void)ba {
    UITextField *tf=[self.view viewWithTag:1];
    [tf resignFirstResponder];
//    self.editing = NO;
//    tf.text = @"";
//    [[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

@end
