//
//  RCTemplateCollectionViewCell.h
//  RCTemplate
//
//  Created by crx on 2021/11/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class RCTemplateModel;

@interface RCTemplateCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) RCTemplateModel *data;

+ (CGFloat)getCellHeightWithData:(RCTemplateModel *)data cellWidth:(CGFloat)cellWidth;

@end

NS_ASSUME_NONNULL_END
