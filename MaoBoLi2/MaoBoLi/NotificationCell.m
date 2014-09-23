//
//  NotificationCell.m
//  labelColor
//
//  Created by Mac_PC on 14-8-26.
//  Copyright (c) 2014年 H0meDev. All rights reserved.
//

#import "NotificationCell.h"

@implementation NotificationCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    
    [self applyConstraints];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)applyConstraints{
    [self.contentView removeConstraints:self.contentView.constraints];
    NSDictionary *viewDicts;
    NSArray *constraints;
    viewDicts = NSDictionaryOfVariableBindings(_label,_labelDetail,_button);
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_button]-10-|" options:0 metrics:nil views:viewDicts];
    [self.contentView addConstraints:constraints];
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_label]" options:0 metrics:nil views:viewDicts];
    [self.contentView addConstraints:constraints];
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_labelDetail]" options:0 metrics:nil views:viewDicts];
    [self.contentView addConstraints:constraints];
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_label]-10-[_labelDetail]-10-|" options:0 metrics:nil views:viewDicts];
    [self.contentView addConstraints:constraints];
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_button]-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:viewDicts];
    [self.contentView addConstraints:constraints];

    
 /*   if ([_labelDetail.text isEqualToString:@""]) {
        NSLog(@"xuuxuxh");
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_label]-20-|" options:0 metrics:nil views:viewDicts];
        [self.contentView addConstraints:constraints];
    }
    else{
        NSLog(@"heheheh");
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_label]-10-[_labelDetail]-20-|" options:0 metrics:nil views:viewDicts];
        [self.contentView addConstraints:constraints];
    }*/
}

@end
