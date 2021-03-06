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


#pragma mark - ????????????
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

//????????????(????????????)
- (void)setRoundedCorners:(UIRectCorner)corners radius:(CGSize)radius
{
    CGRect rect = self.bounds;
    
    //???????????????????????????
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radius];
    
    //???????????????????????????????????????
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = rect;
    maskLayer.path = maskPath.CGPath;
    
    //????????????????????????????????????????????????
    self.layer.mask = maskLayer;
}
//????????????(????????????)
- (void)setRoundedCorners:(UIRectCorner)corners radius:(CGSize)radius rect:(CGRect)rect
{
    //???????????????????????????
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radius];
    
    //???????????????????????????????????????
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = rect;
    maskLayer.path = maskPath.CGPath;
    
    //????????????????????????????????????????????????
    self.layer.mask = maskLayer;
}
//???????????????????????????????????????
- (void)concaveWithPositionY:(CGFloat)positionY radius:(CGFloat)radius cornerRadius:(CGFloat)cornerRadius
{
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius];
    
    /**
     ?????????????????????
     
     @param center      ???????????????????????????????????????????????????????????????????????????????????????
     @param radius      ??????????????????????????????????????????????????????
     @param startAngle  ????????????????????????????????????????????????????????????????????????
     @param endAngle    ?????????????????????????????????????????????????????????????????????
     @param clockwise   ??????????????????????????????????????????????????????????????????????????????
     @return            ???????????????????????????
     */
    [bezierPath appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(0, positionY) radius:radius startAngle:M_PI_2 endAngle:M_PI_2 * 3 clockwise:NO]];
    [bezierPath appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMaxX(self.bounds), positionY) radius:radius startAngle:M_PI_2 * 3 endAngle:M_PI_2 clockwise:NO]];
    
    [bezierPath closePath];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = bezierPath.CGPath;
    [self.layer setMask:layer];
    
    CAShapeLayer *lineLayer  = [[CAShapeLayer alloc] init];
    //??????shapeLayer?????????
    lineLayer.frame = self.bounds;
    //???????????????ClearColor
    [lineLayer setFillColor:[UIColor clearColor].CGColor];
    //??????????????????????????????
    [lineLayer setLineWidth:((1 / [UIScreen mainScreen].scale) / 2)];
    [lineLayer setStrokeColor:[UIColor redColor].CGColor];
    //??????????????????????????????(??????????????????)?????????3=????????????????????????2=???????????????????????????
    //[lineLayer setLineDashPattern:@[@3, @2]];
    [lineLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:3], [NSNumber numberWithInt:2], nil]];
    
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:CGPointMake(radius + 5.0, positionY)];
    [linePath addLineToPoint:CGPointMake(CGRectGetMaxX(self.bounds) - (radius + 5), positionY)];
    lineLayer.path = linePath.CGPath;
    
    //???????????????
    [self.layer addSublayer:lineLayer];
}

//????????????
- (void)drawLineOfDashWithLength:(NSInteger)length spacing:(NSInteger)spacing color:(UIColor *)color
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame) * 0.5, CGRectGetHeight(self.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //??????????????????
    [shapeLayer setStrokeColor:color.CGColor];
    //????????????????????????
    [shapeLayer setLineWidth:1.0];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //?????????????????????????????????
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInteger:length], [NSNumber numberWithInteger:spacing], nil]];
    
    //????????????
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(self.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    //?????????????????????????????????
    [self.layer addSublayer:shapeLayer];
}

//????????????
- (void)setEdge:(XYShadowEdge)edge color:(UIColor *)color opacity:(CGFloat)opacity radius:(CGFloat)radius pathWidth:(CGFloat)pathWidth
{
    self.layer.masksToBounds = NO;//????????????YES??????????????????????????????
    
    //?????????????????????????????????????????????
    self.layer.shadowColor = color.CGColor;
    //????????????????????????????????????0????????????????????????
    self.layer.shadowOpacity = opacity;
    /*
     ??????????????????????????????shadowRadius???????????????
     x???y??????UIView????????????width???????????????x???????????????height???????????????y??????????????????x???????????????y???????????????
     */
    self.layer.shadowOffset = CGSizeZero;
    //???????????????????????????????????????
    self.layer.shadowRadius = radius;
    
    CGRect shadowRect;
    
    CGFloat originX = 0;
    CGFloat originY = 0;
    
    CGFloat originW = self.bounds.size.width;
    CGFloat originH = self.bounds.size.height;
    
    //??????shadowPath??????????????????????????????????????????????????????????????????pathWidth????????????pathWidth * 0.5???
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

//??????????????????(?????????????????????)
- (void)shadowsAroundWithCornerRadius:(CGFloat)cornerRadius
{
    //??????????????????????????????Defaults to zero
    self.layer.cornerRadius = cornerRadius;
    //????????????????????????Defaults to opaque black
    self.layer.shadowColor = [UIColor grayColor].CGColor;
    //???????????????????????????Defaults to 0
    self.layer.shadowOpacity = 0.6;
    //??????????????????0??????????????????????????????shadowRadius???????????????Defaults to (0, -3)
    self.layer.shadowOffset = CGSizeZero;
    //???????????????????????????Defaults to 3
    self.layer.shadowRadius = 2.0;
    //??????????????????????????????????????????layer????????????layer????????????????????????????????????????????????????????????NO??????????????????????????????Defaults to NO
    self.layer.masksToBounds = NO;
    //???????????????????????????????????????????????????????????????????????????????????????????????????Defaults to null
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
}

#pragma mark - ???????????????
/*
 ???????????????????????????(0,0)????????????(0,1)????????????(1,0)????????????(1,1)
 startPoint???????????????????????????????????????(0,0)~(1,1)
 endPoint???????????????????????????????????????(0,0)~(1,1)
 */
- (CAGradientLayer *)gradientType:(XYGradientType)gradientType start:(UIColor *)start end:(UIColor *)end
{
    //??????????????????CAGradientLayer??????????????????????????????????????????????????????(????????????)
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    //???????????????????????????????????????CGColor??????
    gradientLayer.colors = @[(__bridge id)start.CGColor, (__bridge id)end.CGColor];
    //??????????????????????????????????????????????????????????????????????????????(0~1)
    gradientLayer.locations = @[@(0.0f), @(1.0f)];
    
    //?????????????????????????????????????????????????????????(0~1)
    switch (gradientType)
    {
        case XYGradientTypeTopToBottom:
        {
            //????????????????????????????????????
            gradientLayer.startPoint = CGPointMake(0.0, 0.0);
            gradientLayer.endPoint = CGPointMake(0.0, 1.0);
        }
            break;
        case XYGradientTypeLeftToRight:
        {
            //????????????????????????????????????
            gradientLayer.startPoint = CGPointMake(0.0, 0.0);
            gradientLayer.endPoint = CGPointMake(1.0, 0.0);
        }
            break;
        case XYGradientTypeTopLeftToBottomRight:
        {
            //???????????????????????????????????????
            gradientLayer.startPoint = CGPointMake(0.0, 0.0);
            gradientLayer.endPoint = CGPointMake(1.0, 1.0);
        }
            break;
        case XYGradientTypeTopRightToBottomLeft:
        {
            //???????????????????????????????????????
            gradientLayer.startPoint = CGPointMake(0.0, 1.0);
            gradientLayer.endPoint = CGPointMake(1.0, 0.0);
        }
            break;
            
        default:
            break;
    }

    return gradientLayer;
}

//???UIView??????????????????
- (void)addTapGestureRecognizerWithTarget:(id)target action:(SEL)action
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    self.userInteractionEnabled = YES;
    [tap addTarget:target action:action];
    [self addGestureRecognizer:tap];
}
//??????UIView?????????????????????
- (void)removeAllSubviews
{
    for (UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
    
    return;
}
//??????UIView??????????????????
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
//??????UIView??????????????????
- (UIViewController *)viewController
{
    //????????????????????????????????????
    UIResponder *next = self.nextResponder;
    
    while (![next isKindOfClass:[UIViewController class]] && next != nil)
    {
        //??????next????????????????????????
        next = next.nextResponder;
    }
    
    return (UIViewController *)next;
}

@end
