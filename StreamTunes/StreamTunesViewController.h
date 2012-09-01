//
//  StreamTunesViewController.h
//  StreamTunes
//
//  Created by Luke Stevens on 11/2/11.
//  Copyright (c) 2011 Southeast Community College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "MusicPlayer.h"

@interface StreamTunesViewController : UIViewController
<UITableViewDelegate,UITableViewDataSource,MusicPlayerDelegate,UIAlertViewDelegate>{
    
    NSMutableArray *songListData;
    NSArray *songData;
    NSMutableArray *playListData;
    BOOL isPlaying;
    BOOL playlistPlaying;
    MusicPlayer *mediaPlayer;
}
@property (weak, nonatomic) IBOutlet UITableView *songList;
@property (weak, nonatomic) IBOutlet UITableView *playlist;
@property (nonatomic, retain) NSMutableArray *songListData;
@property (nonatomic, retain) NSMutableArray *playListData;
@property (nonatomic, retain) NSArray *songData;
@property (nonatomic, retain) AVAudioPlayer *audioPlayer;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

- (IBAction)playButtonPressed:(id)sender;
- (IBAction)nextButtonPressed:(id)sender;
- (IBAction)previousButtonPressed:(id)sender;

- (void) getSongs: (NSString*)ip;
- (void) addToPlaylist:(id)button;
- (void) removeFromPlaylist:(id)button;
- (void) playSong:(id)songButton;
-(void) changeImage;


@end
