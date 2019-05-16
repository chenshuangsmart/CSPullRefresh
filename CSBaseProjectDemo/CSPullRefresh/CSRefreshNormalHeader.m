//
//  CSRefreshNormalHeader.m
//  CSBaseProjectDemo
//
//  Created by cs on 2019/5/15.
//  Copyright © 2019 cs. All rights reserved.
//

#import "CSRefreshNormalHeader.h"

@interface CSRefreshNormalHeader()

/** UIActivityIndicatorView */
@property(nonatomic, weak)UIActivityIndicatorView *loadingView;

@end

@implementation CSRefreshNormalHeader {
    __weak UIImageView *_arrowImgView;
}

#pragma mark - 视图布局 - 重写父类方法

- (void)prepare {
    [super prepare];
    
    self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray; // 默认值
}

- (void)placeSubviews {
    [super placeSubviews];
    
    // 箭头的中心点
    CGFloat arrowCenterX = self.cs_width * 0.5;
    if (!self.stateLbe.isHidden) {
        CGFloat stateWidth = self.stateLbe.cs_textWidth;
        CGFloat timeWidth = 0.0;
        
        if (!self.lastUpdatedTimeLbe.isHidden) {
            timeWidth = self.lastUpdatedTimeLbe.cs_textWidth;
        }
        
        CGFloat textWidth = MAX(stateWidth, timeWidth);
        arrowCenterX = arrowCenterX - textWidth * 0.5 + self.labelLeftDistance;
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
            self.arrowImgView.transform = CGAffineTransformIdentity;
            
            // 添加动画
            [UIView animateWithDuration:kRefreshSlowAnimationDuration animations:^{
                self.loadingView.alpha = 0;
            } completion:^(BOOL finished) {
                // 如果执行完动画发现不是idle状态，就直接返回，进入其他状态
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
                self.arrowImgView.transform = CGAffineTransformIdentity;
            }];
        }
    } else if (state == CSRefreshStatePulling) {    // 正在拖拽中
        [self.loadingView stopAnimating];
        self.arrowImgView.hidden = NO;
        [UIView animateWithDuration:kRefreshFastAnimationDuration animations:^{
            self.arrowImgView.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
        }];
    } else if (state == CSRefreshStateRefreshing) { // 正在刷新中
        self.loadingView.alpha = 1.0;   // 防止refreshing -> normal 的动画完毕动作没有被执行
        [self.loadingView startAnimating];
        self.arrowImgView.hidden = YES;
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
