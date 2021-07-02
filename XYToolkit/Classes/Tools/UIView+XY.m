//
//  UIView+XY.m
//  XYToolkit
//
//  Created by xiaoyu on 2020/8/8.
//

#import "UIView+XY.h"

@implementation UIView (XY)

#pragma mark - setter/getter
- (void)setOriginX:(CGFloat)originX
{
    CGRect rect   = self.frame;
    rect.origin.x = originX;
    self.frame    = rect;
}
- (CGFloat)originX
{
    return self.frame.origin.x;
}

- (void)setOriginY:(CGFloat)originY
{
    CGRect rect   = self.frame;
    rect.origin.y = originY;
    self.frame    = rect;
}
- (CGFloat)originY
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect rect     = self.frame;
    rect.size.width = width;
    self.frame      = rect;
}
- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect rect      = self.frame;
    rect.size.height = height;
    self.frame       = rect;
}
- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setTop:(CGFloat)top
{
    CGRect frame   = self.frame;
    frame.origin.y = top;
    self.frame     = frame;
}
- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame   = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame     = frame;
}
- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setLeft:(CGFloat)left
{
    CGRect frame   = self.frame;
    frame.origin.x = left;
    self.frame     = frame;
}
- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame   = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame     = frame;
}
- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame   = self.frame;
    frame.origin.x = origin.x;
    frame.origin.y = origin.y;
    self.frame     = frame;
}
- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setSize:(CGSize)size
{
    CGRect frame      = self.frame;
    frame.size.width  = size.width;
    frame.size.height = size.height;
    self.frame        = frame;
}
- (CGSize)size
{
    return self.frame.size;
}

- (void)setCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}
- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, centerY);
}
- (CGFloat)centerY
{
    return self.center.y;
}


#pragma mark - 其它扩展
- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
}
- (CGFloat)cornerRadius
{
    return self.layer.cornerRadius;
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = borderWidth;
}
- (CGFloat)borderWidth
{
    return self.layer.borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}
- (UIColor *)borderColor
{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

//设置圆角(绝对布局)
- (void)setRoundedCorners:(UIRectCorner)corners radius:(CGSize)radius
{
    CGRect rect = self.bounds;
    
    //创建贝塞尔曲线路径
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radius];
    
    //创建形状图层，设置它的路径
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = rect;
    maskLayer.path = maskPath.CGPath;
    
    //将新创建的形状层，作为视图的图层
    self.layer.mask = maskLayer;
}
//设置圆角(相对布局)
- (void)setRoundedCorners:(UIRectCorner)corners radius:(CGSize)radius rect:(CGRect)rect
{
    //创建贝塞尔曲线路径
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radius];
    
    //创建形状图层，设置它的路径
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = rect;
    maskLayer.path = maskPath.CGPath;
    
    //将新创建的形状层，作为视图的图层
    self.layer.mask = maskLayer;
}
//制作带凹形圆的卡片、票券等
- (void)concaveWithPositionY:(CGFloat)positionY radius:(CGFloat)radius cornerRadius:(CGFloat)cornerRadius
{
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius];
    
    /**
     创建圆弧线路径
     
     @param center      圆弧圆点，指定用于定义圆弧的圆的中心点（在当前坐标系中）。
     @param radius      圆弧半径，指定用于定义弧的圆的半径。
     @param startAngle  起始弧度位置，指定弧的起始角度（以弧度为单位）。
     @param endAngle    结束弧度位置，指定弧的结束角度（以弧度为单位）
     @param clockwise   是否顺时针方向，绘制弧线的方向，以时钟方向为判断基准
     @return            指定弧的新路径对象
     */
    [bezierPath appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(0, positionY) radius:radius startAngle:M_PI_2 endAngle:M_PI_2 * 3 clockwise:NO]];
    [bezierPath appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMaxX(self.bounds), positionY) radius:radius startAngle:M_PI_2 * 3 endAngle:M_PI_2 clockwise:NO]];
    
    [bezierPath closePath];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = bezierPath.CGPath;
    [self.layer setMask:layer];
    
    CAShapeLayer *lineLayer  = [[CAShapeLayer alloc] init];
    //设置shapeLayer的尺寸
    lineLayer.frame = self.bounds;
    //填充颜色为ClearColor
    [lineLayer setFillColor:[UIColor clearColor].CGColor];
    //设置线条的宽度和颜色
    [lineLayer setLineWidth:((1 / [UIScreen mainScreen].scale) / 2)];
    [lineLayer setStrokeColor:[UIColor redColor].CGColor];
    //设置虚线线段分割模式(线宽、线间距)比如：3=每段线条的宽度，2=每段线条之间的间距
    //[lineLayer setLineDashPattern:@[@3, @2]];
    [lineLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:3], [NSNumber numberWithInt:2], nil]];
    
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:CGPointMake(radius + 5.0, positionY)];
    [linePath addLineToPoint:CGPointMake(CGRectGetMaxX(self.bounds) - (radius + 5), positionY)];
    lineLayer.path = linePath.CGPath;
    
    //添加并显示
    [self.layer addSublayer:lineLayer];
}

//绘制虚线
- (void)drawLineOfDashWithLength:(NSInteger)length spacing:(NSInteger)spacing color:(UIColor *)color
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame) * 0.5, CGRectGetHeight(self.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //设置虚线颜色
    [shapeLayer setStrokeColor:color.CGColor];
    //设置虚线整体宽度
    [shapeLayer setLineWidth:1.0];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //设置虚线每段长度、间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInteger:length], [NSNumber numberWithInteger:spacing], nil]];
    
    //设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(self.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    //把绘制好的虚线添加上来
    [self.layer addSublayer:shapeLayer];
}

//设置阴影
- (void)setEdge:(XYShadowEdge)edge color:(UIColor *)color opacity:(CGFloat)opacity radius:(CGFloat)radius pathWidth:(CGFloat)pathWidth
{
    self.layer.masksToBounds = NO;//若设置为YES，则阴影效果不起作用
    
    //设置阴影的颜色，可设置透明度等
    self.layer.shadowColor = color.CGColor;
    //设置阴影的透明度，默认为0（即看不到阴影）
    self.layer.shadowOpacity = opacity;
    /*
     设置阴影的偏移量，跟shadowRadius配合使用。
     x、y表示UIView左上角，width表示阴影与x的偏移量，height表示阴影与y值的偏移量（x向右偏移，y向下偏移）
     */
    self.layer.shadowOffset = CGSizeZero;
    //阴影半径，阴影模糊度的半径
    self.layer.shadowRadius = radius;
    
    CGRect shadowRect;
    
    CGFloat originX = 0;
    CGFloat originY = 0;
    
    CGFloat originW = self.bounds.size.width;
    CGFloat originH = self.bounds.size.height;
    
    //通过shadowPath实现局部阴影，因为系统的过渡效果，所以偏移为pathWidth的一半（pathWidth * 0.5）
    CGFloat shadowPathWidth = pathWidth * 0.5;
    
    switch (edge)
    {
        case XYShadowEdgeTop:
        {
            shadowRect  = CGRectMake(originX, originY - shadowPathWidth, originW,  pathWidth);
        }
            break;
        case XYShadowEdgeBottom:
        {
            shadowRect  = CGRectMake(originX, originH - shadowPathWidth, originW, pathWidth);
        }
            break;
            
        case XYShadowEdgeLeft:
        {
            shadowRect  = CGRectMake(originX - shadowPathWidth, originY, pathWidth, originH);
        }
            break;
            
        case XYShadowEdgeRight:
        {
            shadowRect  = CGRectMake(originW - shadowPathWidth, originY, pathWidth, originH);
        }
            break;
        case XYShadowEdgeNoTop:
        {
            shadowRect  = CGRectMake(originX - shadowPathWidth, originY + 1, originW + pathWidth, originH + shadowPathWidth);
        }
            break;
        case XYShadowEdgeAllEdge:
        {
            shadowRect  = CGRectMake(originX - shadowPathWidth, originY - shadowPathWidth, originW +  pathWidth, originH + pathWidth);
        }
            break;
    }
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:shadowRect];
    
    self.layer.shadowPath = path.CGPath;
}

//设置阴影环绕(即四周都有阴影)
- (void)shadowsAroundWithCornerRadius:(CGFloat)cornerRadius
{
    //设置图层的圆角半径。Defaults to zero
    self.layer.cornerRadius = cornerRadius;
    //设置阴影的颜色。Defaults to opaque black
    self.layer.shadowColor = [UIColor grayColor].CGColor;
    //设置阴影的透明度。Defaults to 0
    self.layer.shadowOpacity = 0.6;
    //设置偏移量为0，即四周都有阴影。跟shadowRadius配合使用。Defaults to (0, -3)
    self.layer.shadowOffset = CGSizeZero;
    //设置阴影模糊半径。Defaults to 3
    self.layer.shadowRadius = 2.0;
    //剪切边界。如果视图上的子视图layer超出视图layer部分就截取掉；如果添加阴影这个属性必须是NO，不然会把阴影切掉。Defaults to NO
    self.layer.masksToBounds = NO;
    //设置阴影的绘制路径。减少离屏渲染时间，解决阴影卡顿问题，提高性能。Defaults to null
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
}

#pragma mark - 设置渐变色
/*
 渐变色方向：左上角(0,0)、左下角(0,1)、右上角(1,0)、右下角(1,1)
 startPoint：渐变色起始位置，取值范围(0,0)~(1,1)
 endPoint：渐变色终止位置，取值范围(0,0)~(1,1)
 */
- (CAGradientLayer *)gradientType:(XYGradientType)gradientType start:(UIColor *)start end:(UIColor *)end
{
    //设置渐变色。CAGradientLayer类对其绘制渐变背景颜色、填充层的形状(包括圆角)
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    //设置渐变色数组，需要转换为CGColor颜色
    gradientLayer.colors = @[(__bridge id)start.CGColor, (__bridge id)end.CGColor];
    //设置渐变色的变化分布区间位置，默认平均分布，取值范围(0~1)
    gradientLayer.locations = @[@(0.0f), @(1.0f)];
    
    //设置渐变区域的起始和终止位置，取值范围(0~1)
    switch (gradientType)
    {
        case XYGradientTypeTopToBottom:
        {
            //设置渐变色方向：竖直渐变
            gradientLayer.startPoint = CGPointMake(0.0, 0.0);
            gradientLayer.endPoint = CGPointMake(0.0, 1.0);
        }
            break;
        case XYGradientTypeLeftToRight:
        {
            //设置渐变色方向：水平渐变
            gradientLayer.startPoint = CGPointMake(0.0, 0.0);
            gradientLayer.endPoint = CGPointMake(1.0, 0.0);
        }
            break;
        case XYGradientTypeTopLeftToBottomRight:
        {
            //设置渐变色方向：左上到右下
            gradientLayer.startPoint = CGPointMake(0.0, 0.0);
            gradientLayer.endPoint = CGPointMake(1.0, 1.0);
        }
            break;
        case XYGradientTypeTopRightToBottomLeft:
        {
            //设置渐变色方向：左下到右上
            gradientLayer.startPoint = CGPointMake(0.0, 1.0);
            gradientLayer.endPoint = CGPointMake(1.0, 0.0);
        }
            break;
            
        default:
            break;
    }

    return gradientLayer;
}

//为UIView添加点击手势
- (void)addTapGestureRecognizerWithTarget:(id)target action:(SEL)action
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    self.userInteractionEnabled = YES;
    [tap addTarget:target action:action];
    [self addGestureRecognizer:tap];
}
//移除UIView上的所有子视图
- (void)removeAllSubviews
{
    for (UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
    
    return;
}
//设置UIView为第一响应者
- (UIView *)firstResponderView
{
    for (UIView *view in [self subviews])
    {
        if ([self isFirstResponder])
        {
            return self;
        }
        UIView *firstResponderView = [view firstResponderView];
        if (nil == firstResponderView)
        {
            continue;
        }
        else
        {
            return firstResponderView;
        }
    }
    return nil;
}
//获取UIView所在的控制器
- (UIViewController *)viewController
{
    //获取当前对象的下一响应者
    UIResponder *next = self.nextResponder;
    
    while (![next isKindOfClass:[UIViewController class]] && next != nil)
    {
        //获取next对象的下一响应者
        next = next.nextResponder;
    }
    
    return (UIViewController *)next;
}

@end
