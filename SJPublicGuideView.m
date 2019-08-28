//
//  SJPublicGuideView.m
//  WarmCurrent
//
//  Created by Jay on 2018/10/11.
//  Copyright © 2018 广州暖心流网络科技有限公司（本内容仅限于广州暖心流网络科技有限公司内部传阅，禁止外泄以及用于其他的商业目的）. All rights reserved.
//

#import "SJPublicGuideView.h"

#define WCImageTag  (5587)

@interface SJPublicGuideView ()

@property (nonatomic, strong) NSArray<WCGuideStep*>*steps;

@property (nonatomic, copy) NSString *identifier;

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, strong) UIView * emptyView;

@property (nonatomic, assign) NSInteger lastImageCount;//!<上一步骤的图片用于清除

@end

@implementation SJPublicGuideView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self layoutUI];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

#pragma mark - + method
/** 是否引导过了 */
+ (BOOL)isGuideShowedWithIdentifier:(NSString *)identifier {
    
    if (identifier.length == 0) {
        return NO;
    }
    return [[NSUserDefaults standardUserDefaults]boolForKey:identifier];
}

/** 引导、直接在keyWindow 上 */
+ (void)showGuideSteps:(NSArray<WCGuideStep*>*)steps identifier:(NSString *)identifier {
    [self showOnView:[UIApplication sharedApplication].keyWindow guideSteps:steps identifier:identifier];
}

/** 引导 */
+(void)showOnView:(UIView *)superView guideSteps:(NSArray<WCGuideStep *> *)steps identifier:(nonnull NSString *)identifier{
    if (identifier.length > 0) {
        BOOL hasShow = [[NSUserDefaults standardUserDefaults]boolForKey:identifier];
        if (hasShow) {
            return;
        }
    }
    
    SJPublicGuideView *guideView = [[SJPublicGuideView alloc]initWithFrame:superView.bounds];
    guideView.alpha = 0;
    guideView.identifier = identifier;
    guideView.steps = steps;
    [superView addSubview:guideView];
    [UIView animateWithDuration:.3 animations:^{
        guideView.alpha = 1;
    }];
}

#pragma mark - setupUI
- (void)setupUI {
    self.emptyView = [[UIView alloc]initWithFrame:self.bounds];
    self.emptyView.backgroundColor = [UIColor colorWithWhite:0 alpha:.7];
    [self addSubview:self.emptyView];
}

#pragma mark - layoutUI
- (void)layoutUI {
    
}

#pragma mark - setter
- (void)setSteps:(NSArray<WCGuideStep *> *)steps {
    _steps = steps;
    if (steps.count > 0) {
        [self updateMarkWithStep:self.steps[0]];
    }
}

#pragma mark - events
- (void)tap:(UITapGestureRecognizer *)tap {
    self.currentIndex ++;
    if (self.currentIndex >= self.steps.count) {
        if (self.identifier.length > 0) {
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:self.identifier];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
        [UIView animateWithDuration:.3 animations:^{
            self.alpha = 0;
        }completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }else {
        [self updateMarkWithStep:self.steps[self.currentIndex]];
    }
}


#pragma mark - pravite method
- (void)updateMarkWithStep:(WCGuideStep *)step{
    self.layer.mask = nil;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.emptyView.qmui_width, self.emptyView.qmui_height)];
    for (UIBezierPath *bezierPath in step.emptyArr) {
        [path appendPath:[bezierPath bezierPathByReversingPath]];
    }
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    [self.emptyView.layer setMask:shapeLayer];
    
    for (int i = 0; i < self.lastImageCount; i ++) {
        UIView *view = [self viewWithTag:WCImageTag + i];
        view.tag = 0;
        [view removeFromSuperview];
    }
    self.lastImageCount = step.guideImages.count;
    for (int i = 0; i < step.guideImages.count; i ++) {
        SJGuideStepImage *stepImage = step.guideImages[i];
        UIImageView *guideImageView = [UIImageView new];
        guideImageView.tag = WCImageTag + i;
        guideImageView.contentMode = UIViewContentModeScaleAspectFit;
        guideImageView.image = stepImage.image;
        guideImageView.frame = stepImage.imageFrame;
        [self addSubview:guideImageView];
    }
    
}

#pragma mark - lazy load


@end


@implementation WCGuideStep

- (void)addEmptyPath:(UIBezierPath *)emptyPath {
    if (!_emptyArr) {
        _emptyArr = [NSMutableArray new];
    }
    [_emptyArr addObject:emptyPath];
}

- (void)addEmptyCornerWithConers:(UIRectCorner)corners cornerRadius:(CGFloat)cornerRadius emptyFrame:(CGRect)frame{
    if (!_emptyArr) {
        _emptyArr = [NSMutableArray new];
    }
    [_emptyArr addObject:[UIBezierPath bezierPathWithRoundedRect:frame byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)]];
}

/** 添加图片 */
- (void)addImage:(UIImage*)guideImage frame:(CGRect)guideImageFrame {
    if (!_guideImages) {
        _guideImages = [NSMutableArray new];
    }
    SJGuideStepImage *stepImage = [SJGuideStepImage new];
    stepImage.image = guideImage;
    stepImage.imageFrame = guideImageFrame;
    [_guideImages addObject:stepImage];
}

@end

@implementation SJGuideStepImage
@end
