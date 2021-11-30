//
//  RCCollectionViewAdaptiveHeightLayout.h
//  RCTemplate
//
//  Created by crx on 2021/11/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** 使用这个布局的UICollectionView的delegate必须实现RCCollectionViewDelegateAdaptiveHeightLayout协议 */
@interface RCCollectionViewAdaptiveHeightLayout : UICollectionViewLayout

/** 默认10 */
@property (nonatomic, assign) CGFloat lineSpacing;
/** 默认10 */
@property (nonatomic, assign) CGFloat interitemSpacing;
/** 这个布局只有一个section */
@property (nonatomic, assign) UIEdgeInsets sectionInset;

@end



/**
 * 这个协议用于RCCollectionViewAdaptiveHeightLayout，
 * 由UICollectionView的delegate这个对象实现这些方法。
 */
@protocol RCCollectionViewDelegateAdaptiveHeightLayout <UICollectionViewDelegate>

@required
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
