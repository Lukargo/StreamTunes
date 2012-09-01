//
//  PlaylistCell.h
//  StreamTunes
//
//  Created by Luke Stevens on 11/24/11.
//  Copyright (c) 2011 Southeast Community College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Song.h"

@interface PlaylistCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *removeButton;
@property (weak, nonatomic) IBOutlet UILabel *songLabel;

@property (weak, nonatomic) Song *songHolder;

@end
