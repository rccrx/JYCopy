//
//  RCTabBar.m
//  RCMain
//
//  Created by crx on 2021/10/20.
//

#import "RCTabBar.h"

@implementation RCTabBar

- (void)setItems:(NSArray<UIControl<RCTabBarItemDelegate> *> *)items {
    [self.items enumerateObjectsUsingBlock:^(UIControl<RCTabBarItemDelegate> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    _items = items;
    
    [self.items enumerateObjectsUsingBlock:^(UIControl<RCTabBarItemDelegate> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj addTarget:self action:@selector(tabBarButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(CGRectGetWidth(obj.bounds)));
            make.height.equalTo(@(CGRectGetHeight(obj.bounds)));
            make.centerY.equalTo(self);
            make.centerX.equalTo(self.mas_left).offset(self.itemCenterXLRMargin + self.itemSpacing * idx);
        }];
    }];
}

- (void)setItemCenterXLRMargin:(CGFloat)itemCenterXLRMargin {
    _itemCenterXLRMargin = itemCenterXLRMargin;
    [self.items enumerateObjectsUsingBlock:^(UIControl<RCTabBarItemDelegate> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_left).offset(self.itemCenterXLRMargin + self.itemSpacing * idx);
        }];
    }];
}

- (void)setItemSpacing:(CGFloat)itemSpacing {
    _itemSpacing = itemSpacing;
    [self.items enumerateObjectsUsingBlock:^(UIControl<RCTabBarItemDelegate> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_left).offset(self.itemCenterXLRMargin + self.itemSpacing * idx);
        }];
    }];
}

#pragma mark - Action
- (void)tabBarButtonDidClicked:(UIControl *)sender {
    sender.selected = !sender.selected;
}

@end
