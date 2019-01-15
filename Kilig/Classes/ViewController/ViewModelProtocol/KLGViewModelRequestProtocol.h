//
//  KLGViewModelRequestProtocol.h
//  Pods
//
//  Created by chenyusen on 2018/6/12.
//

#ifndef KLGViewModelRequestProtocol_h
#define KLGViewModelRequestProtocol_h
#import <Foundation/Foundation.h>
typedef void(^KLGRequestSuccess)(id data);
typedef void(^KLGRequestFailure)(NSError *error);

@protocol KLGViewModelRequestProtocol<NSObject>

@property (nonatomic, strong) NSDictionary *klg_paramters;

- (void)klg_asyncRequestWithSuccess:(KLGRequestSuccess)success
                            failure:(KLGRequestFailure)failure;
@end

#endif /* KLGViewModelRequestProtocol_h */
