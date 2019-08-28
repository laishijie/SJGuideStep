//
//  SJPublicGuideView.h
//  WarmCurrent
//
//  Created by Jay on 2018/10/11.
//  Copyright © 2018 广州暖心流网络科技有限公司（本内容仅限于广州暖心流网络科技有限公司内部传阅，禁止外泄以及用于其他的商业目的）. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SJGuideStepImage :NSObject

@property (nonatomic, strong) UIImage * image;
@property (nonatomic, assign) CGRect imageFrame;

@end

@interface WCGuideStep : NSObject
/** 步骤中的全有图片 */
@property (nonatomic, strong , readonly) NSMutableArray<SJGuideStepImage *>* guideImages;

@property (nonatomic, strong , readonly) NSMutableArray<UIBezierPath*>* emptyArr;

/** 添加抠空1 */
- (void)addEmptyCornerWithConers:(UIRectCorner)corners cornerRadius:(CGFloat)cornerRadius emptyFrame:(CGRect)frame;
/** 添加抠空2 */
- (void)addEmptyPath:(UIBezierPath *)emptyPath;
/** 添加图片 */
- (void)addImage:(UIImage*)guideImage frame:(CGRect)guideImageFrame;

@end

@interface SJPublicGuideView : UIView

/** 是否引导过了 */
+ (BOOL)isGuideShowedWithIdentifier:(NSString *)identifier;

/** 引导
 * @param steps 引导
 * @param identifier 唯一标识，只引导一次
 */
+ (void)showOnView:(UIView*)superView guideSteps:(NSArray<WCGuideStep*>*)steps identifier:(NSString *)identifier;

/** 引导、直接在keyWindow 上
 * @param steps 引导
 * @param identifier 唯一标识，只引导一次
 */
+ (void)showGuideSteps:(NSArray<WCGuideStep*>*)steps identifier:(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
