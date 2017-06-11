#import "TreemapView.h"
#import "TreemapViewCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation TreemapViewCell

@synthesize valueLabel;
@synthesize textLabel;
@synthesize index;
@synthesize delegate;

// Height of the labels
int labelFrameHeight = 20;

// Horizontal margin on right and left of the label
int hSafeMargin = 2;

#pragma mark -

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = [[UIColor whiteColor] CGColor];

        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(hSafeMargin, 0, frame.size.width - hSafeMargin * 2, labelFrameHeight)];
        textLabel.font = [UIFont systemFontOfSize:18];
        textLabel.baselineAdjustment = UIBaselineAdjustmentNone;
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.textColor = [UIColor whiteColor];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.lineBreakMode = NSLineBreakByCharWrapping;
        textLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:textLabel];

        self.valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(hSafeMargin, 0, frame.size.width - hSafeMargin * 2, labelFrameHeight)];
        valueLabel.font = [UIFont systemFontOfSize:12];
        valueLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        valueLabel.textAlignment = NSTextAlignmentCenter;
        valueLabel.textColor = [UIColor whiteColor];
        valueLabel.backgroundColor = [UIColor clearColor];
        valueLabel.lineBreakMode = NSLineBreakByCharWrapping;
        valueLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:valueLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (textLabel.frame.size.height > self.frame.size.height) {
        // Text label too big to fit in the treemap view cell. We remove labels
        [textLabel removeFromSuperview];
        [valueLabel removeFromSuperview];
    }
    else {
        // Adjust label to the size of the text, and keep centered
        textLabel.frame = CGRectMake(hSafeMargin, self.frame.size.height / 3 - (labelFrameHeight / 2), self.frame.size.width - 4, textLabel.frame.size.height);
        valueLabel.frame = CGRectMake(hSafeMargin, self.frame.size.height / 3 + (labelFrameHeight / 2), self.frame.size.width - 4, valueLabel.frame.size.height);
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];

    if (delegate && [delegate respondsToSelector:@selector(treemapViewCell:tapped:)]) {
        [delegate treemapViewCell:self tapped:index];
    }
}

@end
