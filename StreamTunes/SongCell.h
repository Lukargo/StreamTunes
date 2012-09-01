//
//  SongCell.h
//  StreamTunes
//
//  Created by Luke Stevens on 11/20/11.
//  Copyright (c) 2011 Southeast Community College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Song.h"

@interface SongCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIButton *songName;

@property (weak, nonatomic) IBOutlet UIButton *addButton;

@property (weak, nonatomic) NSString *songLocation;

@property (weak, nonatomic) Song *songHolder;

@end
