//
//  CSRefreshBackNormalFooter.m
//  CSBaseProjectDemo
//
//  Created by cs on 2019/5/18.
//  Copyright © 2019 cs. All rights reserved.
//

#import "CSRefreshBackNormalFooter.h"

@interface CSRefreshBackNormalFooter()

/** loading */
@property(nonatomic, weak)UIActivityIndicatorView *loadingView;

@end

@implementation CSRefreshBackNormalFooter {
    __weak UIImageView *_arrowImgView;  // 箭头
}

#pragma mark - 视图布局 重写父类方法

- (void)prepare {
    [super prepare];
    
    self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray; // 默认值
}

- (void)placeSubviews {
    [super placeSubviews];
    
    // 箭头的中心点
    CGFloat arrowCenterX = self.cs_width * 0.5;
    if (!self.stateLbe.isHidden) {
        arrowCenterX -= self.stateLbe.cs_textWidth * 0.5 + self.labelLeftDistance;
    }
    
    CGFloat arrowCenterY = self.cs_height * 0.5;
    CGPoint arrowCenter = CGPointMake(arrowCenterX, arrowCenterY);
    
    // 箭头
    if (self.arrowImgView.constraints.count == 0) {
        self.arrowImgView.cs_size = self.arrowImgView.image.size;
        self.arrowImgView.center = arrowCenter;
    }
    
    // 圆圈
    if (self.loadingView.constraints.count == 0) {
        self.loadingView.center = arrowCenter;
    }
    
    self.arrowImgView.tintColor = self.stateLbe.textColor;
}

#pragma mark - set

- (void)setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle {
    _activityIndicatorViewStyle = activityIndicatorViewStyle;
    
    self.loadingView = nil;
    
    [self setNeedsLayout];
}

- (void)setState:(CSRefreshState)state {
    CSRefreshStateCheck
    
    // 根据状态做事情
    if (state == CSRefreshStateNormal) {
        if (oldState == CSRefreshStateRefreshing) { // 由刷新->默认状态
            self.arrowImgView.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
            
            // 添加动画
            [UIView animateWithDuration:kRefreshSlowAnimationDuration animations:^{
                self.loadingView.alpha = 0;
            } completion:^(BOOL finished) {
                // 防止动画结束后，状态已经不是 CSRefreshStateNormal
                if (self.state != CSRefreshStateNormal) {
                    return;
                }
                
                self.loadingView.alpha = 1.0;
                [self.loadingView stopAnimating];
                self.arrowImgView.hidden = NO;
            }];
        } else {
            [self.loadingView stopAnimating];
            self.arrowImgView.hidden = NO;
            [UIView animateWithDuration:kRefreshFastAnimationDuration animations:^{
                self.arrowImgView.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
            }];
        }
    } else if (state == CSRefreshStatePulling) {    // 正在拖拽中
        [self.loadingView stopAnimating];
        self.arrowImgView.hidden = NO;
        [UIView animateWithDuration:kRefreshFastAnimationDuration animations:^{
            self.arrowImgView.transform = CGAffineTransformIdentity;
        }];
    } else if (state == CSRefreshStateRefreshing) { // 正在刷新中
        self.loadingView.alpha = 1.0;   // 防止refreshing -> normal 的动画完毕动作没有被执行
        [self.loadingView startAnimating];
        self.arrowImgView.hidden = YES;
    } else if (state == CSRefreshStateNoMoreData) {  // 数据加载完毕
        self.arrowImgView.hidden = YES;
        [self.loadingView stopAnimating];
    }
}

#pragma mark - lazy

- (UIImageView *)arrowImgView {
    if (_arrowImgView == nil) {
        UIImageView *arrowImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
        [self addSubview:_arrowImgView = arrowImgView];
    }
    return _arrowImgView;
}

- (UIActivityIndicatorView *)loadingView {
    if (_loadingView == nil) {
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:self.activityIndicatorViewStyle];
        loadingView.hidesWhenStopped = YES;
        [self addSubview:_loadingView = loadingView];
    }
    return _loadingView;
}

@end
