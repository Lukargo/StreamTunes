//
//  MusicPlayer.m
//  StreamTunes
//
//  Created by Luke Stevens on 11/20/11.
//  Copyright (c) 2011 Southeast Community College. All rights reserved.
//

#import "MusicPlayer.h"


@interface MusicPlayer ()

- (void) advancePlaylist;

@end

@implementation MusicPlayer
@synthesize delegate;

AVAudioPlayer *audioPlayer;
NSMutableArray *playlist;
NSInteger activeIndex = 0;
BOOL playlistMode = NO;

-(void) playSong:(NSString *)location{
    
    
    NSError *error;
    
    NSData *songMusicData = [NSData dataWithContentsOfURL:[NSURL URLWithString:location]];
    
    audioPlayer = [[AVAudioPlayer alloc] initWithData:songMusicData error:&error];
    audioPlayer.volume = 1.0f;
    
    
    [audioPlayer prepareToPlay];
    
    [audioPlayer setDelegate:self];
    
    [audioPlayer play];
}



-(void) updatePlaylist:(NSMutableArray *)playList{
    playlist = playList;
    
    NSLog(@"Update Array: %@", playlist);
    
    
}




-(void)removeSong:(NSUInteger)index{
    
    
    if(index == activeIndex)
        [self advancePlaylist];
    
}


- (void) playPlaylist{
    playlistMode = YES;
    
    activeIndex = -1;
    [self advancePlaylist];
    
    
}

- (void) pausePlayer{
    [audioPlayer pause];
}

-(void) resumePlayer{
    [audioPlayer play];
}

-(void) nextSong{
    [self advancePlaylist];
}

-(void) previousSong{
    if (activeIndex > 0){
        activeIndex--;
        [self playSong:[[playlist objectAtIndex:activeIndex]location]];
        [[self delegate] songChanged:activeIndex];
    } else if (activeIndex == 0) {
        [self playSong:[[playlist objectAtIndex:activeIndex]location]];
        [[self delegate] songChanged:activeIndex];
    }
}

- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    
    
    if (flag){
        if(playlistMode && activeIndex != playlist.count-1){
            [self advancePlaylist];     
        } else {
            activeIndex = -1;
            [[self delegate] playerDidFinishPlaying];
        }
    }
        
}

-(void) advancePlaylist {
    if(activeIndex < (NSInteger) playlist.count - 1){
        activeIndex++;
    }else{
        [audioPlayer stop];
        [delegate playerDidFinishPlaying];
        return;
    }
    
    [self playSong:[[playlist objectAtIndex:activeIndex]location]];
    [[self delegate] songChanged:activeIndex];


}




@end
