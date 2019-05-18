//
//  CSRefreshAutoNormalFooter.h
//  CSBaseProjectDemo
//
//  Created by cs on 2019/5/18.
//  Copyright © 2019 cs. All rights reserved.
//

#import "CSRefreshAutoStateFooter.h"

NS_ASSUME_NONNULL_BEGIN

/**
 上拉加载更多 - 默认样式
 */
@interface CSRefreshAutoNormalFooter : CSRefreshAutoStateFooter

/** 菊花的样式 */
@property(nonatomic, assign)UIActivityIndicatorViewStyle activityIndicatorViewStyle;

@end

NS_ASSUME_NONNULL_END
