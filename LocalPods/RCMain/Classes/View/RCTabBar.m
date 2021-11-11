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
        if (idx == 0) {
            self.selectedItem = obj;
        }
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
- (void)tabBarButtonDidClicked:(UIControl<RCTabBarItemDelegate> *)sender {
    if ([self.delegate respondsToSelector:@selector(tabBar:shouldSelectItem:)] && ![self.delegate tabBar:self shouldSelectItem:sender]) {
        return;
    }
    
    self.selectedItem = sender;
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectItem:)]) {
        [self.delegate tabBar:self didSelectItem:sender];
    }
}

#pragma mark - Setter & Getter
- (void)setSelectedItem:(UIControl<RCTabBarItemDelegate> *)selectedItem {
    if (![self.items containsObject:selectedItem]) {
        return;
    }
    if (_selectedItem != selectedItem) {
        _selectedItem.selected = NO;
        selectedItem.selected = YES;
        _selectedItem = selectedItem;
    }
}

@end
