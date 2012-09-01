//
//  MusicPlayer.h
//  StreamTunes
//
//  Created by Luke Stevens on 11/20/11.
//  Copyright (c) 2011 Southeast Community College. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "Song.h"

@protocol MusicPlayerDelegate <NSObject>

-(void)songChanged: (NSUInteger) index;
-(void)playerDidFinishPlaying;

@end

@interface MusicPlayer : NSObject <AVAudioPlayerDelegate>{
    
}

@property (nonatomic,retain) id <MusicPlayerDelegate> delegate;

-(void) playSong: (NSString *) location;
-(void) updatePlaylist: (NSMutableArray *)playList;
-(void) playPlaylist;
-(void) pausePlayer;
-(void) previousSong;
-(void) nextSong;
-(void) resumePlayer;

-(void)removeSong:(NSUInteger) index;


@end
