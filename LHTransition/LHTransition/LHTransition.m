//
//  LHTransition.m
//  LHTransition
//
//  Created by Apple on 17/2/7.
//  Copyright © 2017年 Linitial. All rights reserved.
//

#import "LHTransition.h"
#import "ViewController.h"
#import "ToViewController.h"
#import "UIView+Extension.h"

@interface LHTransition () <UIGestureRecognizerDelegate>

@property (nonatomic, assign) TransitionType type;

@property (nonatomic, assign) CGFloat scale;

@property (nonatomic, assign) CGPoint position;

@property (nonatomic, strong) UIPanGestureRecognizer *gesture;


@end

@implementation LHTransition


- (instancetype)initWithTransitionType:(TransitionType)type {
    if (self = [super init]) {
        _type = type;
        _scale = 0.9f;
        
    }
    return self;
}

- (void)setPanEnable:(BOOL)panEnable {
    _panEnable = panEnable;
    if (!_panEnable) {
        return;
    }
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return .4;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    switch (_type) {
        case TransitionTypePush:
            [self push:transitionContext];
            break;
        case TransitionTypePop:
            [self pop:transitionContext];
            break;
        default:
            break;
    }
}

- (void)push:(id<UIViewControllerContextTransitioning>)transitionContext {
    ViewController *fromVC = (ViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ToViewController *toVC = (ToViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    UIView *toView = toVC.view;
    CGRect finalRect = toView.frame;
    [toView hideSubviews];
    UITableViewCell *cell = [fromVC.tableView cellForRowAtIndexPath:fromVC.currentIndexPath];
    CGRect tempRect = [[UIApplication sharedApplication].keyWindow convertRect:cell.frame fromView:fromVC.tableView];
    toView.frame = tempRect;
    self.position = toView.layer.position;

    [containerView addSubview:toView];

    [UIView animateWithDuration:0.6
                     animations:^{
        fromVC.view.transform = CGAffineTransformScale(fromVC.view.transform, self.scale, self.scale);
    }completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:[self transitionDuration:transitionContext]
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 toView.layer.position = self.position;
                                 toView.frame = finalRect;
                             }
                             completion:^(BOOL finished) {
                                 if (finished) {
                                     [UIView animateWithDuration:0.3
                                                      animations:^{
                                         [toView showSubviews];
                                     }];
                                 }
                                 [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                             }];
        }
    }];
    

}

- (void)pop:(id<UIViewControllerContextTransitioning>)transitionContext {
    ToViewController *fromVC = (ToViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toVC.view;
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toView];
    toView.backgroundColor = [UIColor whiteColor];
    [containerView bringSubviewToFront:toView];
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                    animations:^{
                        fromVC.view.alpha = 0;
                        toVC.view.layer.transform = CATransform3DIdentity;
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];

}

@end
