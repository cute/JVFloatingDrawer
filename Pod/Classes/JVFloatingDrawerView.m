//
//  JVFloatingDrawerView.m
//  JVFloatingDrawer
//
//  Created by Julian Villella on 2015-01-11.
//  Copyright (c) 2015 JVillella. All rights reserved.
//

#import "JVFloatingDrawerView.h"

static const CGFloat kJVDefaultViewContainerWidth = 300.0;

@interface JVFloatingDrawerView ()

@property (nonatomic, strong) NSLayoutConstraint *leftViewContainerWidthConstraint;
@property (nonatomic, strong) NSLayoutConstraint *rightViewContainerWidthConstraint;
@property (nonatomic, strong) CALayer *shadowLayer;

@end

@implementation JVFloatingDrawerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

#pragma mark - View Setup

- (void)setup
{
    [self setupBackgroundImageView];
    [self setupCenterViewContainer];
    [self setupLeftViewContainer];
    [self setupRightViewContainer];

    [self bringSubviewToFront:self.centerViewContainer];
    [self.centerViewContainer addObserver:self forKeyPath:@"transform" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)setupBackgroundImageView
{
    _backgroundImageView = [[UIImageView alloc] init];

    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.backgroundImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:self.backgroundImageView];

    NSArray *constraints = @[
        [NSLayoutConstraint constraintWithItem:self.backgroundImageView
                                     attribute:NSLayoutAttributeLeading
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeLeading
                                    multiplier:1.0
                                      constant:0.0],
        [NSLayoutConstraint constraintWithItem:self.backgroundImageView
                                     attribute:NSLayoutAttributeTrailing
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeTrailing
                                    multiplier:1.0
                                      constant:0.0],
        [NSLayoutConstraint constraintWithItem:self.backgroundImageView
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeTop
                                    multiplier:1.0
                                      constant:0.0],
        [NSLayoutConstraint constraintWithItem:self.backgroundImageView
                                     attribute:NSLayoutAttributeBottom
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeBottom
                                    multiplier:1.0
                                      constant:0.0],
    ];

    [self addConstraints:constraints];
}

- (void)setupLeftViewContainer
{
    _leftViewContainer = [[UIView alloc] init];

    [self.leftViewContainer setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:self.leftViewContainer];

    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.leftViewContainer
                                                                       attribute:NSLayoutAttributeWidth
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:nil
                                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                                      multiplier:1.0
                                                                        constant:kJVDefaultViewContainerWidth];
    NSArray *constraints = @[
        [NSLayoutConstraint constraintWithItem:self.leftViewContainer
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeHeight
                                    multiplier:1.0
                                      constant:0.0],
        [NSLayoutConstraint constraintWithItem:self.leftViewContainer
                                     attribute:NSLayoutAttributeTrailing
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeLeading
                                    multiplier:1.0
                                      constant:0.0],
        [NSLayoutConstraint constraintWithItem:self.leftViewContainer
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeTop
                                    multiplier:1.0
                                      constant:0.0],
        widthConstraint
    ];

    [self addConstraints:constraints];

    self.leftViewContainerWidthConstraint = widthConstraint;
}

- (void)setupRightViewContainer
{
    _rightViewContainer = [[UIView alloc] init];

    [self.rightViewContainer setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:self.rightViewContainer];

    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.rightViewContainer
                                                                       attribute:NSLayoutAttributeWidth
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:nil
                                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                                      multiplier:1.0
                                                                        constant:kJVDefaultViewContainerWidth];
    NSArray *constraints = @[
        [NSLayoutConstraint constraintWithItem:self.rightViewContainer
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeHeight
                                    multiplier:1.0
                                      constant:0.0],
        [NSLayoutConstraint constraintWithItem:self.rightViewContainer
                                     attribute:NSLayoutAttributeLeading
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeTrailing
                                    multiplier:1.0
                                      constant:0.0],
        [NSLayoutConstraint constraintWithItem:self.rightViewContainer
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeTop
                                    multiplier:1.0
                                      constant:0.0],
        widthConstraint
    ];

    [self addConstraints:constraints];

    self.rightViewContainerWidthConstraint = widthConstraint;
}

- (void)setupCenterViewContainer
{
    _centerViewContainer = [[UIView alloc] init];

    [self.centerViewContainer setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:self.centerViewContainer];

    NSArray *constraints = @[
        [NSLayoutConstraint constraintWithItem:self.centerViewContainer
                                     attribute:NSLayoutAttributeLeading
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeLeading
                                    multiplier:1.0
                                      constant:0.0],
        [NSLayoutConstraint constraintWithItem:self.centerViewContainer
                                     attribute:NSLayoutAttributeTrailing
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeTrailing
                                    multiplier:1.0
                                      constant:0.0],
        [NSLayoutConstraint constraintWithItem:self.centerViewContainer
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeTop
                                    multiplier:1.0
                                      constant:0.0],
        [NSLayoutConstraint constraintWithItem:self.centerViewContainer
                                     attribute:NSLayoutAttributeBottom
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeBottom
                                    multiplier:1.0
                                      constant:0.0],
    ];

    [self addConstraints:constraints];
}

#pragma mark - Reveal Widths

- (void)setLeftViewContainerWidth:(CGFloat)leftViewContainerWidth
{
    self.leftViewContainerWidthConstraint.constant = leftViewContainerWidth;
}

- (void)setRightViewContainerWidth:(CGFloat)rightViewContainerWidth
{
    self.rightViewContainerWidthConstraint.constant = rightViewContainerWidth;
}

- (CGFloat)leftViewContainerWidth
{
    return self.leftViewContainerWidthConstraint.constant;
}

- (CGFloat)rightViewContainerWidth
{
    return self.rightViewContainerWidthConstraint.constant;
}

#pragma mark - Helpers

- (UIView *)viewContainerForDrawerSide:(JVFloatingDrawerSide)drawerSide
{
    UIView *viewContainer = nil;
    switch (drawerSide) {
        case JVFloatingDrawerSideLeft:
            viewContainer = self.leftViewContainer;
            break;
        case JVFloatingDrawerSideRight:
            viewContainer = self.rightViewContainer;
            break;
        case JVFloatingDrawerSideNone:
            viewContainer = nil;
            break;
    }
    return viewContainer;
}

#pragma mark - Open/Close Events

- (void)willOpenFloatingDrawerViewController:(JVFloatingDrawerViewController *)viewController
{
    UIView *view = self.centerViewContainer.subviews.firstObject;
    view.userInteractionEnabled = NO;

    CALayer *layer = self.centerViewContainer.layer;
    if (!self.shadowLayer) {
        CALayer *shadowLayer = [CALayer layer];
        self.shadowLayer = shadowLayer;
        shadowLayer.backgroundColor = [[UIColor colorWithWhite:0 alpha:0.3] CGColor];
        shadowLayer.opacity = 0;
    }

    self.shadowLayer.frame = layer.bounds;
    [layer addSublayer:self.shadowLayer];
}

- (void)willCloseFloatingDrawerViewController:(JVFloatingDrawerViewController *)viewController
{
    UIView *view = self.centerViewContainer.subviews.firstObject;
    view.userInteractionEnabled = YES;
    [self.shadowLayer removeFromSuperlayer];
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"transform"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey, id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"transform"]) {
        CGAffineTransform value = [change[NSKeyValueChangeNewKey] CGAffineTransformValue];
        self.shadowLayer.opacity = value.tx / kJVDefaultViewContainerWidth;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.shadowLayer.frame = self.bounds;
}

@end
