//
//  PlaylistCell.m
//  StreamTunes
//
//  Created by Luke Stevens on 11/24/11.
//  Copyright (c) 2011 Southeast Community College. All rights reserved.
//

#import "PlaylistCell.h"

@implementation PlaylistCell
@synthesize removeButton;
@synthesize songLabel;
@synthesize songHolder;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
