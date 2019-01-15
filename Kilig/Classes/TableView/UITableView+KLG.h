//
//  UITableView+KLG.h
//  Kilig
//
//  Created by chenyusen on 2018/5/17.
//

#import <UIKit/UIKit.h>

@class KLGTableViewModel;
@class KLGTableViewAction;

NS_ASSUME_NONNULL_BEGIN


/**
 UITableView在进入编辑状态时的选择模式类型
 
 - KLGTableViewEditTypeMultiSelection: 多选
 */
typedef NS_ENUM(NSInteger, KLGTableViewEditType) {
    KLGTableViewEditTypeMultiSelection
};

@interface UITableView (KLG)

/**
 行使UITableViewDataSource的职责
 */
@property (nonatomic, strong) KLGTableViewModel *klg_tableViewModel;

/**
 行使UITableViewDelegate的职责
 */
@property (nonatomic, strong, readonly) KLGTableViewAction *klg_tableViewAction;

/**
 UITableView在进入编辑状态时的选择模式
 */
@property (nonatomic, assign) KLGTableViewEditType klg_editType;

@end
NS_ASSUME_NONNULL_END
