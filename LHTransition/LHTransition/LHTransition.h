//
//  LHTransition.h
//  LHTransition
//
//  Created by Apple on 17/2/7.
//  Copyright © 2017年 Linitial. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TransitionType) {
    TransitionTypePush,
    TransitionTypePop
};

@interface LHTransition : NSObject <UIViewControllerAnimatedTransitioning>

- (instancetype)initWithTransitionType:(TransitionType)type;

@property (nonatomic, assign, getter=isPanEnable) BOOL panEnable;

@end
