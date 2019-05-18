//
//  CSRefreshBackNormalFooter.h
//  CSBaseProjectDemo
//
//  Created by cs on 2019/5/18.
//  Copyright © 2019 cs. All rights reserved.
//

#import "CSRefreshBackStateFooter.h"

NS_ASSUME_NONNULL_BEGIN

/**
 上拉加载更多 - 停止拖拽返回后刷新 - 默认样式
 */
@interface CSRefreshBackNormalFooter : CSRefreshBackStateFooter
/** 箭头 */
@property(nonatomic, weak, readonly)UIImageView *arrowImgView;
/** 菊花的样式 */
@property(nonatomic, assign)UIActivityIndicatorViewStyle activityIndicatorViewStyle;
@end

NS_ASSUME_NONNULL_END
