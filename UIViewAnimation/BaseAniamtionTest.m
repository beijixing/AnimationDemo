//
//  BaseAniamtionTest.m
//  UIViewAnimation
//
//  Created by ybon on 16/2/17.
//  Copyright © 2016年 ybon. All rights reserved.
//

#import "BaseAniamtionTest.h"

@interface BaseAniamtionTest ()
{
    UIView *_animView;
    CGFloat SCREEN_HEIGHT;
    CGFloat SCREEN_WIDTH;
}
@end

@implementation BaseAniamtionTest

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SCREEN_HEIGHT = self.view.frame.size.height;
    SCREEN_WIDTH = self.view.frame.size.width;
    
    self.view.backgroundColor = [UIColor whiteColor];
    _animView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    _animView.backgroundColor = [UIColor redColor];
    [self.view addSubview: _animView];
    
    [self createButtonWithTitle:@"移动" frame:CGRectMake(30, 400, 40, 40) tag:0];
    [self createButtonWithTitle:@"闪烁" frame:CGRectMake(80, 400, 40, 40) tag:1];
    [self createButtonWithTitle:@"缩放" frame:CGRectMake(130, 400, 40, 40) tag:2];
    [self createButtonWithTitle:@"旋转" frame:CGRectMake(180, 400, 40, 40) tag:3];
    [self createButtonWithTitle:@"透明度" frame:CGRectMake(230, 400, 60, 40) tag:3];
}


- (UIButton *)createButtonWithTitle:(NSString *)title frame:(CGRect)frame tag:(NSInteger)tag {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor grayColor];
    button.tag = tag;
    [self.view addSubview:button];
    
    return button;
}

- (void)buttonClick:(UIButton*)sender {
    NSInteger tag = sender.tag;
    switch (tag) {
        case 0:
            [self positionAnimation];
            break;
        case 1:
            [self opacityAniamtion];
            break;
        case 2:
            [self scaleAnimation];
            break;
        case 3:
            [self rotateAnimation];
            break;
        default:
            break;
    }
}

- (void)positionAnimation {
/*如果fillMode=kCAFillModeForwards和removedOnComletion=NO，那么在动画执行完毕后，图层会保持显示动画执行后的状态。但在实质上，图层的属性值还是动画执行前的初始值，并没有真正被改变。
    正确的姿势应该要兼具两点：1. 在表现层能完美地完成动画； 2.在模型层能及时地更新数据。
*/
    CABasicAnimation *basicAnim = [CABasicAnimation animationWithKeyPath:@"position"];
    basicAnim.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, SCREEN_HEIGHT/2-50)];
    basicAnim.toValue = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT/2-50)];
    basicAnim.duration = 1.0;
//    basicAnim.fillMode = kCAFillModeForwards;
//    basicAnim.removedOnCompletion = YES;
    basicAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
//    _animView.layer.position = CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT/2-50);
    [_animView.layer addAnimation:basicAnim forKey:@"positionAnimation"];
    
}

/**
 *  透明度动画
 */
-(void)opacityAniamtion{
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"opacity"];
    anima.fromValue = [NSNumber numberWithFloat:1.0f];
    anima.toValue = [NSNumber numberWithFloat:0.2f];
    anima.duration = 1.0f;
    [_animView.layer addAnimation:anima forKey:@"opacityAniamtion"];
}

/**
 *  缩放动画
 */
-(void)scaleAnimation{
//    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"bounds"];
//    anima.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 200, 200)];
//    anima.duration = 1.0f;
//    [_animView.layer addAnimation:anima forKey:@"scaleAnimation"];
//    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.scale"];//同上
//    anima.toValue = [NSNumber numberWithFloat:2.0f];
//    anima.duration = 1.0f;
//    [_animView.layer addAnimation:anima forKey:@"scaleAnimation"];
    
     CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
     anima.toValue = [NSNumber numberWithFloat:0.2f];
     anima.duration = 1.0f;
     [_animView.layer addAnimation:anima forKey:@"scaleAnimation"];
}

/**
 *  旋转动画
 */
-(void)rotateAnimation{
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//绕着z轴为矢量，进行旋转(@"transform.rotation.z"==@@"transform.rotation")
    anima.toValue = [NSNumber numberWithFloat:M_PI];
    anima.duration = 1.0f;
    [_animView.layer addAnimation:anima forKey:@"rotateAnimation"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"animationDidStop");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
