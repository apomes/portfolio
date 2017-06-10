#import "TreemapView.h"
#import "TreemapViewCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation TreemapViewCell

@synthesize valueLabel;
@synthesize textLabel;
@synthesize index;
@synthesize delegate;

#pragma mark -

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = [[UIColor whiteColor] CGColor];

        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width - 4, 20)];
        textLabel.font = [UIFont boldSystemFontOfSize:20];
        textLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.textColor = [UIColor whiteColor];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.lineBreakMode = NSLineBreakByCharWrapping;
        textLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:textLabel];

        self.valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width - 4, 20)];
        valueLabel.font = [UIFont boldSystemFontOfSize:20];
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

    textLabel.frame = CGRectMake(0, self.frame.size.height / 2 - 10, self.frame.size.width, 20);
    valueLabel.frame = CGRectMake(0, self.frame.size.height / 2 + 10, self.frame.size.width, 20);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];

    if (delegate && [delegate respondsToSelector:@selector(treemapViewCell:tapped:)]) {
        [delegate treemapViewCell:self tapped:index];
    }
}

@end
