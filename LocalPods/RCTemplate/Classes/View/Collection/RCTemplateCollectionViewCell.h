//
//  RCTemplateCollectionViewCell.h
//  RCTemplate
//
//  Created by crx on 2021/11/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class RCEditTemplate;

@interface RCTemplateCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) RCEditTemplate *data;
@property (nonatomic, strong, readonly) UIImageView *coverImageView;

+ (CGFloat)getCellHeightWithData:(RCEditTemplate *)data cellWidth:(CGFloat)cellWidth;

@end

NS_ASSUME_NONNULL_END
