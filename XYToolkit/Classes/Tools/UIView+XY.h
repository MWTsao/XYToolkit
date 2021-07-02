//
//  UIView+XY.h
//  XYToolkit
//
//  Created by xiaoyu on 2020/8/8.
//

#import <UIKit/UIKit.h>

/** 阴影面/有阴影的边 */
typedef NS_ENUM(NSUInteger, XYShadowEdge)
{
    XYShadowEdgeTop = 0,    ///< 顶部阴影
    XYShadowEdgeBottom,     ///< 底部阴影
    XYShadowEdgeLeft,       ///< 左侧阴影
    XYShadowEdgeRight,      ///< 右侧阴影
    XYShadowEdgeNoTop,      ///< 左、右、下三面阴影
    XYShadowEdgeAllEdge     ///< 上、下、左、右四周阴影
};
/** 渐变类型 */
typedef NS_ENUM(NSUInteger, XYGradientType)
{
    XYGradientTypeTopToBottom = 0,      ///< 从上到小
    XYGradientTypeLeftToRight,          ///< 从左到右
    XYGradientTypeTopLeftToBottomRight, ///< 左上到右下
    XYGradientTypeTopRightToBottomLeft  ///< 左下到右上
};

NS_ASSUME_NONNULL_BEGIN
//让你的自定义 UIView 可以在 IB 中预览。
IB_DESIGNABLE

@interface UIView (XY)

@property (nonatomic, assign) CGFloat originX;  ///< 获取视图自身的X坐标(left)
@property (nonatomic, assign) CGFloat originY;  ///< 获取视图自身的Y坐标(top)

@property (nonatomic, assign) CGFloat width;    ///< 获取视图自身的宽度
@property (nonatomic, assign) CGFloat height;   ///< 获取视图自身的高度

@property (nonatomic, assign) CGFloat top;      ///< 获取视图自身的顶点(Y坐标)
@property (nonatomic, assign) CGFloat bottom;   ///< 获取视图自身的底点(Y坐标+自身高度)

@property (nonatomic, assign) CGFloat left;     ///< 获取视图自身的左点(X坐标)
@property (nonatomic, assign) CGFloat right;    ///< 获取视图自身的右点(X坐标+自身宽度)

@property (nonatomic, assign) CGPoint origin;   ///< 原点/位置
@property (nonatomic, assign) CGSize  size;     ///< 大小/尺寸

@property (nonatomic, assign) CGFloat centerX;  ///< 中心点X
@property (nonatomic, assign) CGFloat centerY;  ///< 中心点Y


#pragma mark - 其它扩展

@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;///< 可视化设置圆角
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;///< 可视化设置边框宽度
@property (nonatomic, strong) IBInspectable UIColor *borderColor;///< 可视化设置边框颜色

/**
 *  设置圆角(绝对布局)
 *
 *  @param corners  圆角：UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radius    圆角大小，例如：CGSizeMake(20.0, 20.0)
 */
- (void)setRoundedCorners:(UIRectCorner)corners radius:(CGSize)radius;
/**
 *  设置圆角(相对布局)
 *
 *  @param corners   圆角：UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radius     圆角大小，例如：CGSizeMake(20.0, 20.0)
 *  @param rect         圆角的rect
 */
- (void)setRoundedCorners:(UIRectCorner)corners radius:(CGSize)radius rect:(CGRect)rect;

/**
 制作带凹形圆的卡片、票券等
 
 @param positionY           凹圆的Y坐标
 @param radius                  凹圆的半径
 @param cornerRadius    卡片四个角的半径
 */
- (void)concaveWithPositionY:(CGFloat)positionY radius:(CGFloat)radius cornerRadius:(CGFloat)cornerRadius;

/**
 通过 CAShapeLayer 方式绘制水平方向虚线
 @param length 虚线的长度
 @param spacing 虚线的间距
 @param color 虚线的颜色
 */
- (void)drawLineOfDashWithLength:(NSInteger)length spacing:(NSInteger)spacing color:(UIColor *)color;

/**
 设置阴影
 
 @param edge            阴影面
 @param color          阴影的颜色
 @param opacity      阴影的透明度，默认0
 @param radius        阴影的模糊度半径，默认3.0
 @param pathWidth 阴影的路径宽度
 */
- (void)setEdge:(XYShadowEdge)edge color:(UIColor *)color opacity:(CGFloat)opacity radius:(CGFloat)radius pathWidth:(CGFloat)pathWidth;

/**
 设置阴影环绕(即四周都有阴影)

 @param cornerRadius 设置图层四周的圆角半径
 */
- (void)shadowsAroundWithCornerRadius:(CGFloat)cornerRadius;

/// 设置渐变
/// @param gradientType 渐变类型
/// @param start 渐变开始颜色
/// @param end 渐变结束颜色
- (CAGradientLayer *)gradientType:(XYGradientType)gradientType start:(UIColor *)start end:(UIColor *)end;

/**
 添加点击手势
 
 @param target 轻击手势触发的目标
 @param action 轻击手势触发的方法
 */
- (void)addTapGestureRecognizerWithTarget:(id)target action:(SEL)action;
/**
 *  移除UIView上的所有子视图
 */
- (void)removeAllSubviews;
/**
 *  设置UIView为第一响应者
 */
- (UIView *)firstResponderView;
/**
 *  获取UIView所在的控制器
 */
- (UIViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
