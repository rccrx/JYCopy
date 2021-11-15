//
//  RCTemplateSearchTextField.m
//  RCTemplate
//
//  Created by crx on 2021/11/15.
//

#import "RCTemplateSearchTextField.h"

@interface RCTemplateSearchTextField ()
@property (nonatomic, assign) CGFloat searchIconWidth;
@property (nonatomic, assign) CGFloat clearIconWidth;
@end

@implementation RCTemplateSearchTextField

- (instancetype)init {
    UIImage *searchIcon = [UIImage rte_imageNamedInTemplateBundle:@"search"];
    UIImage *clearIcon = [UIImage rte_imageNamedInTemplateBundle:@"clear"];
    return [self initWithSearchIcon:searchIcon clearIcon:clearIcon];
}

- (instancetype)initWithSearchIcon:(UIImage *)searchIcon clearIcon:(UIImage *)clearIcon {
    if (self = [super initWithSearchIcon:searchIcon clearIcon:clearIcon]) {
        _searchIconWidth = searchIcon.size.width;
        _clearIconWidth =  clearIcon.size.width;
        self.customRightViewMode = RCTextFieldViewModeWhileHasText;
        self.backgroundColor = UIColor.rte_color282828;
        self.tintColor = UIColor.rte_colorFCCF14;
        self.textColor = UIColor.whiteColor;
        self.font = Font_PFSC_R(14);
        self.placeholderColor = UIColor.rte_color8C8C8C;
        self.layer.cornerRadius = 15;
    }
    return self;
}

- (void)setupViewRectWithSearchTFWidth:(CGFloat)searchTFWidth searchTFheight:(CGFloat)searchTFHeight {
    CGFloat searchLeftMargin = 8;
    self.leftViewRect = CGRectMake(searchLeftMargin, 0, self.searchIconWidth, searchTFHeight);
    
    CGFloat clearRightMargin = 10;
    CGFloat clearWidth = self.clearIconWidth;
    self.rightViewRect = CGRectMake(searchTFWidth - clearWidth - clearRightMargin, 0, clearWidth, searchTFHeight);
    
    CGFloat editingToSearchMargin = 6;
    CGFloat editingToClearMargin = 12;
    CGFloat editingX = CGRectGetMaxX(self.leftViewRect) + editingToSearchMargin;
    self.editingRect = CGRectMake(editingX, 0, CGRectGetMinX(self.rightViewRect) - editingToClearMargin - editingX, searchTFHeight);
    self.textRect = self.editingRect;
    self.placeholderRect = self.editingRect;
}

@end
