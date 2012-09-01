//
//  SongCell.m
//  StreamTunes
//
//  Created by Luke Stevens on 11/20/11.
//  Copyright (c) 2011 Southeast Community College. All rights reserved.
//

#import "SongCell.h"
#import "StreamTunesViewController.h"
#import "MusicPlayer.h"

@implementation SongCell
@synthesize songName;
@synthesize addButton;
@synthesize songLocation;
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
