//
//  KLGViewControllerProtocol.h
//  Pods
//
//  Created by chenyusen on 2018/6/29.
//

#ifndef KLGViewControllerProtocol_h
#define KLGViewControllerProtocol_h
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN
/**
 当前控制器
 
 - KLGViewControllerContentStatusNormal: 正常状态
 - KLGViewControllerContentStatusEmpty: 空数据状态
 - KLGViewControllerContentStatusFail: 加载失败状态
 - KLGViewControllerContentStatusNoNetwork: 无网状态
 */
typedef NS_ENUM(NSInteger, KLGViewControllerContentStatus) {
    KLGViewControllerContentStatusNormal,
    KLGViewControllerContentStatusEmpty,
    KLGViewControllerContentStatusFail,
    KLGViewControllerContentStatusNoNetwork
};


@protocol KLGViewControllerProtocol<NSObject>

@optional
/**
 展示/隐藏加载视图

 @param show 展示/隐藏
 */
- (void)klg_showLoading:(BOOL)show;

/**
 自定义试图控制器的LoadingView

 @return 自定义LoadingView
 */
- (UIView *)klg_customLoadingView;

/**
 是否展示指定状态的状态视图

 @param status 指定状态
 @return 是否显示
 */
- (BOOL)klg_showContentStatusViewWithStatus:(KLGViewControllerContentStatus)status;

/**
 指定状态的描述文案

 @param status 指定状态
 @return 描述文案
 */
- (NSString *)klg_ContentStatusStringWithStatus:(KLGViewControllerContentStatus)status;

/**
 指定状态的富文本描述文案, 优先级高于 klg_ContentStatusStringWithStatus:

 @param status 指定状态
 @return 富文本描述文案
 */
- (NSAttributedString *)klg_ContentStatusAttributedStringWithStatus:(KLGViewControllerContentStatus)status;

/**
 指定状态视图垂直居中的偏移量
 
 @param status 指定状态
 @return 垂直居中的偏移量
 */
- (CGFloat)klg_ContentStatusViewOffsetYWithStatus:(KLGViewControllerContentStatus)status;
@end

NS_ASSUME_NONNULL_END

#endif /* KLGViewControllerProtocol_h */
