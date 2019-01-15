//
//  KLGTableViewCellItem.m
//  Kilig
//
//  Created by chenyusen on 2018/5/22.
//

#import "KLGTableViewCellItem.h"
KLGTableViewCellItemKey const KLGTableViewCellModelAttribute = @"com.kilig.KLGTableViewCellItemKey.KLGTableViewCellModelAttribute";
KLGTableViewCellItemKey const KLGTableViewCellHeightAttribute = @"com.kilig.KLGTableViewCellItemKey.KLGTableViewCellHeightAttribute";
KLGTableViewCellItemKey const KLGTableViewCellClassAttribute = @"com.kilig.KLGTableViewCellItemKey.KLGTableViewCellClassAttribute";
KLGTableViewCellItemKey const KLGTableViewCellNibAttribute = @"com.kilig.KLGTableViewCellItemKey.KLGTableViewCellNibAttribute";
KLGTableViewCellItemKey const KLGTableViewCellRowActionsAttribute = @"com.kilig.KLGTableViewCellItemKey.KLGTableViewCellRowActionsAttribute";
KLGTableViewCellItemKey const KLGTableViewCellStyleAttribute = @"com.kilig.KLGTableViewCellItemKey.KLGTableViewCellStyleAttribute";
KLGTableViewCellItemKey const KLGTableViewCellTapCellActionAttribute = @"com.kilig.KLGTableViewCellItemKey.KLGTableViewCellTapCellActionAttribute";
KLGTableViewCellItemKey const KLGTableViewCellHighlightColorAttribute = @"com.kilig.KLGTableViewCellItemKey.KLGTableViewCellHighlightColorAttribute";
KLGTableViewCellItemKey const KLGTableViewCellStaticCellAttribute = @"com.kilig.KLGTableViewCellItemKey.KLGTableViewCellStaticCellAttribute";


@implementation KLGTableViewCellItem {
    KLGCellHeightBlock _cellHeightBlock;
}

- (instancetype)initWithAttributes:(nullable NSDictionary *)attributes {
    self = [super init];
    if (self) {
        if (attributes) {
            self.model = attributes[KLGTableViewCellModelAttribute];
            self.cellClass = attributes[KLGTableViewCellClassAttribute];
            self.cellNib = attributes[KLGTableViewCellNibAttribute];
            self.rowActions = attributes[KLGTableViewCellRowActionsAttribute];
            self.cellStyle = [attributes[KLGTableViewCellStyleAttribute] integerValue] ?: UITableViewCellStyleDefault;
            self.highlightColor = attributes[KLGTableViewCellHighlightColorAttribute];
            self.tapCellAction = attributes[KLGTableViewCellTapCellActionAttribute];
            self.staticCell = attributes[KLGTableViewCellStaticCellAttribute];
            
            id cellHeight = attributes[KLGTableViewCellHeightAttribute];
            if (cellHeight && [cellHeight respondsToSelector:@selector(doubleValue)]) {
                self.cellHeight = [cellHeight doubleValue];
            } else {
                _cellHeightBlock = cellHeight;
            }
        }
    }
    return self;
}


- (instancetype)initWithModel:(id)model
                    cellClass:(Class)cellClass
                   cellHeight:(CGFloat)cellHeight {
    NSDictionary *attributes = @{
                                 KLGTableViewCellModelAttribute : model ?: @{},
                                 KLGTableViewCellHeightAttribute : @(cellHeight),
                                 KLGTableViewCellClassAttribute : cellClass ?: [UITableViewCell class]
                                 };
    return [self initWithAttributes:attributes];
}

- (CGFloat)cellHeight {
    if (_cellHeightBlock) {
        return _cellHeightBlock(self.model);
    } else {
        return _cellHeight;
    }
}
@end

