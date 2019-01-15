//
//  UIViewController+KLG.h
//  Kilig
//
//  Created by chenyusen on 2018/6/12.
//

#import <UIKit/UIKit.h>
#import "KLGViewViewModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

typedef struct {
    unsigned int isModelDidRefreshInvalid:1;
    unsigned int isModelWillLoadInvalid:1;
    unsigned int isModelDidLoadInvalid:1;
    unsigned int isModelDidLoadFirstTimeInvalid:1;
    unsigned int isModelDidShowFirstTimeInvalid:1;
    unsigned int isViewInvalid:1;
    unsigned int isViewSuspended:1;
    unsigned int isUpdatingView:1;
    unsigned int isShowingEmpty:1;
    unsigned int isShowingLoading:1;
    unsigned int isShowingModel:1;
    unsigned int isShowingError:1;
} KLGViewStateFlags;





@interface UIViewController (KLG)

/**
 当前控制器视图是否正在展示
 */
@property (nonatomic, assign) BOOL klg_isViewAppearing;

/**
 当前控制器视图是否已经展示过
 */
@property (nonatomic, assign) BOOL klg_hasViewAppeard;


/**
 当前视图控制器的ViewModel
 */
@property (nonatomic, strong, nullable) id<KLGViewViewModelProtocol> klg_viewModel;


/**
 正在加载的视图
 */
@property (nonatomic, strong, nullable) UIView *klg_loadingView;


@end
NS_ASSUME_NONNULL_END
