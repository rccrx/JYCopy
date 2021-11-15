//
//  RCTemplateSearchTextField.h
//  RCTemplate
//
//  Created by crx on 2021/11/15.
//

#import "RCSearchTextField.h"

NS_ASSUME_NONNULL_BEGIN

@interface RCTemplateSearchTextField : RCSearchTextField

/** 这个初始化方法使用默认的搜索图标、清除图标 */
- (instancetype)init;
/** 设置默认的leftViewRect、rightViewRect、editingRect、textRect、placeholderRect */
- (void)setupViewRectWithSearchTFWidth:(CGFloat)searchTFWidth searchTFheight:(CGFloat)searchTFHeight;

@end

NS_ASSUME_NONNULL_END
