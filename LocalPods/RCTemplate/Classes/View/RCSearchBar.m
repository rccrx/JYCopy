//
//  RCSearchBar.m
//  RCTemplate
//
//  Created by crx on 2021/11/14.
//

#import "RCSearchBar.h"
#import "RCSearchTextField.h"

@implementation RCSearchBar

- (void)setSearchTextField:(RCSearchTextField *)searchTextField {
    _searchTextField = searchTextField;
    [self addSubview:self.searchTextField];
}

- (void)setCancelButton:(UIButton *)cancelButton {
    _cancelButton = cancelButton;
    [self addSubview:self.cancelButton];
}

@end
