//
//  FriendCell.m
//  InstaBoss
//
//  Created by Fiaz Sami on 2/6/15.
//  Copyright (c) 2015 Aaron Bradley. All rights reserved.
//

#import "FriendCell.h"

@interface FriendCell () <UIGestureRecognizerDelegate>

@property (nonatomic, weak) IBOutlet UIButton *friendButton;
@property (nonatomic, weak) IBOutlet UIView *friendContentView;


@property (nonatomic, strong) UIPanGestureRecognizer *panRecognizer;
@property (nonatomic, assign) CGPoint panStartPoint;
@property (nonatomic, assign) CGFloat startingRightLayoutConstraintConstant;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *contentViewRightConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *contentViewLeftConstraint;

@end

@implementation FriendCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panThisCell:)];
    self.panRecognizer.delegate = self;
    [self.friendContentView addGestureRecognizer:self.panRecognizer];
}

- (void)panThisCell:(UIPanGestureRecognizer *)recognizer {
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            self.panStartPoint = [recognizer translationInView:self.friendContentView];
            NSLog(@"Pan Began at %@", NSStringFromCGPoint(self.panStartPoint));
            break;
        case UIGestureRecognizerStateChanged: {
            CGPoint currentPoint = [recognizer translationInView:self.friendContentView];
            CGFloat deltaX = currentPoint.x - self.panStartPoint.x;
            NSLog(@"Pan Moved %f", deltaX);
        }
            break;
        case UIGestureRecognizerStateEnded:
            NSLog(@"Pan Ended");
            break;
        case UIGestureRecognizerStateCancelled:
            NSLog(@"Pan Cancelled");
            break;
        default:
            break;
    }
}

- (IBAction)socialize:(id)sender {
    [self.delegate socializeWithUser];
}

@end
