//
//  FoldMenuTest.m
//  UIViewAnimation
//
//  Created by ybon on 16/2/19.
//  Copyright © 2016年 ybon. All rights reserved.
//

#import "FoldMenuTest.h"

@interface FoldMenuTest ()
{
    UIButton *_mainButton;
    NSMutableArray *_animViewsArr;
    BOOL isClapsed;
    CGFloat _animationDuration;
}
@end

@implementation FoldMenuTest

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
      
    _animViewsArr = [[NSMutableArray alloc] init];
    int characterAssic = 65;
    for (int i = 0; i< 4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(0, 100, 50, 50);
        button.backgroundColor = [UIColor grayColor];
        [button setTitle:[NSString stringWithFormat:@"%c", characterAssic++] forState:UIControlStateNormal];
        
        
        [self.view addSubview:button];
        button.hidden = YES;
        [_animViewsArr addObject:button];
    }
    
    _mainButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _mainButton.frame = CGRectMake(0, 100, 50, 50);
    [_mainButton setTitle:@"Tap" forState:UIControlStateNormal];
    _mainButton.backgroundColor = [UIColor grayColor];
    [_mainButton addTarget:self action:@selector(mainButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    //    _mainButton.transform = CGAffineTransformMakeRotation(90);
    
    [self.view addSubview:_mainButton];

    
    
    _animationDuration = 0.5;
    isClapsed = YES;
    
}

- (void)mainButtonClicked:(UIButton *)button {
//    _mainButton.transform = CGAffineTransformIdentity;
    isClapsed = !isClapsed;
    if (isClapsed) {
        [self menuFold];
    }else {
        [self menuExpand];
    }
}

- (void)menuFold {
    [CATransaction begin];
    [CATransaction setAnimationDuration:_animationDuration];
    for (int i = 0; i< _animViewsArr.count; i++) {
        UIView *view = _animViewsArr[i];
        CABasicAnimation *posAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
        CGPoint finalPos = CGPointMake(25, 125);
        posAnimation.toValue = [NSValue valueWithCGPoint:finalPos];
        posAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        posAnimation.beginTime = CACurrentMediaTime() + (_animationDuration/(float)_animViewsArr.count*i);
        posAnimation.duration = _animationDuration;
        posAnimation.fillMode = kCAFillModeForwards;
        posAnimation.removedOnCompletion = NO;
        [view.layer addAnimation:posAnimation forKey:@"posAnimation"];
        view.layer.position = finalPos;
        
        
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.duration = _animationDuration;
        scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        scaleAnimation.beginTime = CACurrentMediaTime() + (_animationDuration/(float)_animViewsArr.count *i);
        scaleAnimation.toValue = [NSNumber numberWithFloat:0.01];
        [view.layer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    }
    [CATransaction commit];
    isClapsed = YES;
}

- (void)menuExpand {
    [CATransaction begin];
    [CATransaction setAnimationDuration:_animationDuration];
    [CATransaction setCompletionBlock:^{
        for (UIButton *view in _animViewsArr) {
            view.transform = CGAffineTransformIdentity;
        }
    }];
    
    for (int i = 0; i < _animViewsArr.count; i ++) {
        int index = (int)_animViewsArr.count - (i + 1);
        
        UIView *view = _animViewsArr[index];
        view.hidden = NO;
        CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
        
        CGPoint originPos = CGPointMake(25, 125);
        CGPoint finalPos = CGPointMake(25, 150+10 + 25 + index*(50+10));//_mainButton.position+spacing+newpos
        
        positionAnimation.fromValue = [NSValue valueWithCGPoint:originPos];
        positionAnimation.toValue = [NSValue valueWithCGPoint:finalPos];
        positionAnimation.duration = _animationDuration;
        positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
        positionAnimation.fillMode = kCAFillModeForwards;
        positionAnimation.removedOnCompletion = NO;
        
        positionAnimation.beginTime = CACurrentMediaTime() + (_animationDuration/(float)_animViewsArr.count *i);
        [view.layer addAnimation:positionAnimation forKey:@"positionAnimation"];
        view.layer.position = finalPos;
        
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.duration = _animationDuration;
        scaleAnimation.fromValue = [NSNumber numberWithFloat:0.01];
        scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];
        scaleAnimation.beginTime = CACurrentMediaTime() + (_animationDuration/(float)_animViewsArr.count * i + 0.03f);
        scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        scaleAnimation.fillMode = kCAFillModeForwards;
        scaleAnimation.removedOnCompletion = NO;
        [view.layer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
        view.transform = CGAffineTransformMakeScale(0.01, 0.01);
        
        CABasicAnimation *rotaionAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotaionAnimation.duration = _animationDuration;
        rotaionAnimation.fromValue = [NSNumber numberWithFloat:0];
        rotaionAnimation.toValue = [NSNumber numberWithFloat:M_PI*2];
        rotaionAnimation.beginTime = CACurrentMediaTime() + (_animationDuration/(float)_animViewsArr.count * i + 0.03f);
        rotaionAnimation.fillMode = kCAFillModeForwards;
        rotaionAnimation.removedOnCompletion = NO;
        [view.layer addAnimation:rotaionAnimation forKey:@"rotaionAnimation"];
    }
    
    [CATransaction commit];
    isClapsed = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
