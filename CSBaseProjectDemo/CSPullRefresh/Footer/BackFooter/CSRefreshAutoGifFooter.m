//
//  CSRefreshAutoGifFooter.m
//  CSBaseProjectDemo
//
//  Created by cs on 2019/5/18.
//  Copyright © 2019 cs. All rights reserved.
//

#import "CSRefreshAutoGifFooter.h"

@interface CSRefreshAutoGifFooter() {
    __weak UIImageView *_gifImgView;    // gif img view
}
/** 所有状态对应的动画图片 */
@property(nonatomic, strong)NSMutableDictionary *stateImgsJson;
/** 所有状态对应的动画时间 */
@property(nonatomic, strong)NSMutableDictionary *stateDurationJson;

@end

@implementation CSRefreshAutoGifFooter

#pragma mark - 视图布局

- (void)prepare {
    [super prepare];
    
    // 初始化间距
    self.labelLeftDistance = 20;
}

- (void)placeSubviews {
    [super placeSubviews];
    
    // 外界已经添加约束布局了
    if (self.gifImgView.constraints.count) {
        return;
    }
    
    self.gifImgView.frame = self.bounds;
    
    if (self.isRefreshingTitleHidden) {
        self.gifImgView.contentMode = UIViewContentModeCenter;
    } else {
        self.gifImgView.contentMode = UIViewContentModeRight;
        self.gifImgView.cs_width = self.cs_width * 0.5 - self.labelLeftDistance - self.stateLbe.cs_textWidth * 0.5;
    }
}

#pragma mark - set

- (void)setImages:(NSArray<UIImage *> *)images forState:(CSRefreshState)state {
    [self setImages:images duration:images.count * 0.1 forState:state];
}

- (void)setImages:(NSArray<UIImage *> *)images duration:(NSTimeInterval)duration forState:(CSRefreshState)state {
    if (images == nil || images.count == 0) {
        return;
    }
    
    self.stateImgsJson[@(state)] = images;
    self.stateDurationJson[@(state)] = @(duration);
    
    // 根据图片设置控件的高度
    UIImage *img = images.firstObject;
    if (img.size.height > self.cs_height) {
        self.cs_height = img.size.height;
    }
}

- (void)setState:(CSRefreshState)state {
    CSRefreshStateCheck;
    
    // 根据状态做一些事情
    if (state == CSRefreshStateRefreshing) {  // 刷新中
        NSArray *imgs = self.stateImgsJson[@(state)];
        if (imgs.count == 0) {
            return;
        }
        
        [self.gifImgView stopAnimating];
        self.gifImgView.hidden = NO;
        
        if (imgs.count == 1) {  // 单张图片
            self.gifImgView.image = [imgs lastObject];
        } else {    // 多张图片
            self.gifImgView.animationImages = imgs;
            self.gifImgView.animationDuration = [self.stateDurationJson[@(state)] doubleValue];
            [self.gifImgView startAnimating];
        }
    } else if (state == CSRefreshStateNormal || state == CSRefreshStateNoMoreData) { // 默认状态下-停止动画
        [self.gifImgView stopAnimating];
        self.gifImgView.hidden = YES;
    }
}

#pragma mark - lazy

- (UIImageView *)gifImgView {
    if (_gifImgView == nil) {
        UIImageView *gifImgView = [[UIImageView alloc] init];
        [self addSubview:_gifImgView = gifImgView];
    }
    return _gifImgView;
}

- (NSMutableDictionary *)stateImgsJson {
    if (_stateImgsJson == nil) {
        _stateImgsJson = [NSMutableDictionary dictionary];
    }
    return _stateImgsJson;
}

- (NSMutableDictionary *)stateDurationJson {
    if (_stateDurationJson == nil) {
        _stateDurationJson = [NSMutableDictionary dictionary];
    }
    return _stateDurationJson;
}

@end
