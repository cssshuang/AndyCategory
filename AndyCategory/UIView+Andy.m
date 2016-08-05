//
//  UIView+Andy.m
//  AndyCategory_Test
//
//  Created by 李扬 on 16/8/4.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import "UIView+Andy.h"

@implementation UIView (Andy)

- (CGSize)andy_Size
{
    return self.frame.size;
}

- (void)setAndy_Size:(CGSize)andy_Size
{
    CGRect frame = self.frame;
    frame.size = andy_Size;
    self.frame = frame;
}

- (CGFloat)andy_Width
{
    return self.frame.size.width;
}

- (void)setAndy_Width:(CGFloat)andy_Width
{
    CGRect frame = self.frame;
    frame.size.width = andy_Width;
    self.frame = frame;
}

- (CGFloat)andy_Height
{
    return self.frame.size.height;
}

- (void)setAndy_Height:(CGFloat)andy_Height
{
    CGRect frame = self.frame;
    frame.size.height = andy_Height;
    self.frame = frame;
}

- (CGFloat)andy_X
{
    return self.frame.origin.x;
}

- (void)setAndy_X:(CGFloat)andy_X
{
    CGRect frame = self.frame;
    frame.origin.x = andy_X;
    self.frame = frame;
}

- (CGFloat)andy_Y
{
    return self.frame.origin.y;
}

- (void)setAndy_Y:(CGFloat)andy_Y
{
    CGRect frame = self.frame;
    frame.origin.y = andy_Y;
    self.frame = frame;
}

- (CGFloat)andy_CenterX
{
    return self.center.x;
}

- (void)setAndy_CenterX:(CGFloat)andy_CenterX
{
    CGPoint center = self.center;
    center.x = andy_CenterX;
    self.center = center;
}

- (CGFloat)andy_CenterY
{
    return self.center.y;
}

- (void)setAndy_CenterY:(CGFloat)andy_CenterY
{
    CGPoint center = self.center;
    center.y = andy_CenterY;
    self.center = center;
}


- (BOOL)andy_isShowingOnKeyWindow
{
    // 主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    // 以主窗口左上角为坐标原点, 计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect winBounds = keyWindow.bounds;
    
    // 主窗口的bounds 和 self的矩形框 是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    
    return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && intersects;
}

+ (instancetype)andy_viewFromXib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (BOOL)andy_intersectsWithView:(UIView *)view
{
    //都先转换为相对于窗口的坐标，然后进行判断是否重合
    CGRect selfRect = [self convertRect:self.bounds toView:nil];
    CGRect viewRect = [view convertRect:view.bounds toView:nil];
    return CGRectIntersectsRect(selfRect, viewRect);
}

- (void)andy_removeAllSubviews
{
    while ([self.subviews count] > 0)
    {
        UIView *subview = [self.subviews objectAtIndex:0];
        [subview removeFromSuperview];
    }
}
- (void)andy_removeViewWithTag:(NSInteger)tag
{
    if (tag == 0)
    {
        return;
    }
    UIView *view = [self viewWithTag:tag];
    if (view != nil)
    {
        [view removeFromSuperview];
    }
}
- (void)andy_removeSubViewArray:(NSMutableArray *)views
{
    for (UIView *sub in views)
    {
        [sub removeFromSuperview];
    }
}

- (void)andy_removeViewWithTags:(NSArray *)tagArray
{
    for (NSNumber *num in tagArray)
    {
        [self andy_removeViewWithTag:[num integerValue]];
    }
}
- (void)andy_removeViewWithTagLessThan:(NSInteger)tag
{
    NSMutableArray *views = [NSMutableArray array];
    for (UIView *view in self.subviews)
    {
        if (view.tag > 0 && view.tag < tag)
        {
            [views addObject:view];
        }
    }
    [self andy_removeSubViewArray:views];
}
- (void)andy_removeViewWithTagGreaterThan:(NSInteger)tag
{
    NSMutableArray *views = [NSMutableArray array];
    for (UIView *view in self.subviews)
    {
        if (view.tag > 0 && view.tag > tag)
        {
            [views addObject:view];
        }
    }
    [self andy_removeSubViewArray:views];
}

- (UIViewController*)andy_selfViewController
{
    for (UIView* next = [self superview]; next != nil; next = next.superview)
    {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}


- (UIView *)andy_subviewWithTag:(NSInteger)tag
{
    for (UIView *sub in self.subviews)
    {
        if (sub.tag == tag)
        {
            return sub;
        }
    }
    return nil;
}

@end