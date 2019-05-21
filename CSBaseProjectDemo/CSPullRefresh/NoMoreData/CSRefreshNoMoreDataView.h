//
//  CSRefreshNoMoreDataView.h
//  CSBaseProjectDemo
//
//  Created by cs on 2019/5/21.
//  Copyright © 2019 cs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 没有更多数据视图
 */
@interface CSRefreshNoMoreDataView : UIView

/**
 无数据视图

 @param frame frame
 @param title title
 @return view
 */
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;

/** titleLbe */
@property(nonatomic, weak, readonly)UILabel *titleLbe;

/** 父控件 */
@property (weak, nonatomic, readonly) UIScrollView *scrollView;

@end

NS_ASSUME_NONNULL_END
