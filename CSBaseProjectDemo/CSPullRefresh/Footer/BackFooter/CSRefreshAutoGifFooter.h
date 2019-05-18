//
//  CSRefreshAutoGifFooter.h
//  CSBaseProjectDemo
//
//  Created by cs on 2019/5/18.
//  Copyright © 2019 cs. All rights reserved.
//

#import "CSRefreshAutoStateFooter.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSRefreshAutoGifFooter : CSRefreshAutoStateFooter

/** gif */
@property(nonatomic, weak, readonly)UIImageView *gifImgView;

/** 默认动画持续时间为 图片张数 * 0.1S */
- (void)setImages:(NSArray<UIImage *> *)images forState:(CSRefreshState)state;

/**
 设置 state 状态下的动画图片:images 动画持续时间:duration
 
 @param images 动画图片
 @param duration 持续时间
 @param state 状态
 */
- (void)setImages:(NSArray<UIImage *> *)images duration:(NSTimeInterval)duration forState:(CSRefreshState)state;

@end

NS_ASSUME_NONNULL_END
