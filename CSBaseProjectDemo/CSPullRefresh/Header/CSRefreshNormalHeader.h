//
//  CSRefreshNormalHeader.h
//  CSBaseProjectDemo
//
//  Created by cs on 2019/5/15.
//  Copyright © 2019 cs. All rights reserved.
//

#import "CSRefreshStateHeader.h"

NS_ASSUME_NONNULL_BEGIN

/**
 默认下拉刷新控件 箭头 + 文字
 */
@interface CSRefreshNormalHeader : CSRefreshStateHeader

/** arrow */
@property(nonatomic, weak, readonly)UIImageView *arrowImgView;
/** 菊花样式 */
@property(nonatomic, assign)UIActivityIndicatorViewStyle activityIndicatorViewStyle;

@end

NS_ASSUME_NONNULL_END
