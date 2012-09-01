//
//  StreamTunesViewController.m
//  StreamTunes
//
//  Created by Luke Stevens on 11/2/11.
//  Copyright (c) 2011 Southeast Community College. All rights reserved.
//

#import "StreamTunesViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "SongCell.h"
#import "Song.h"
#import "PlaylistCell.h"



@implementation StreamTunesViewController
@synthesize songList;
@synthesize playlist;
@synthesize audioPlayer;
@synthesize playButton;
@synthesize songListData;
@synthesize songData;
@synthesize playListData;




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"IP"
                                                      message:@"Please enter the IP:"
                                                     delegate:self
                                            cancelButtonTitle:@"Enter"
                                            otherButtonTitles:nil];
    
    message.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    [message show];
    
    
    mediaPlayer = [[MusicPlayer alloc] init];
    [mediaPlayer setDelegate:self];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    NSLog(@"The title is the following: %@", title);
    
    if([title isEqualToString:@"Enter"])
    {
        UITextField *inputIP = [alertView textFieldAtIndex:0];
        NSString *ip = inputIP.text;
        [self getSongs:ip];
    }
}

- (void)viewDidUnload
{
    [self setPlaylist:nil];
    [self setPlayButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (IBAction)playButtonPressed:(id)sender {
    if(isPlaying){
        [mediaPlayer pausePlayer];
        isPlaying = NO;
        [self changeImage];
    }
    else{
    
    if(playListData.count > 0){
    
        if(!playlistPlaying){
            [mediaPlayer playPlaylist];
            playlistPlaying = YES;
        }
        else
            [mediaPlayer resumePlayer];
        isPlaying = YES;
        [self changeImage];
    }
        
    }
}

- (IBAction)nextButtonPressed:(id)sender {
    [mediaPlayer nextSong];
}

- (IBAction)previousButtonPressed:(id)sender {
    [mediaPlayer previousSong];
}

-(void) getSongs: (NSString*)ip{
     NSLog(@"Made it this far");
    NSString *serviceIP = @"http://";
    serviceIP = [serviceIP stringByAppendingString:ip];
    serviceIP = [serviceIP stringByAppendingString:@"/StreamTunes/"];
    
    
    NSLog(serviceIP);
    
    NSURL *url = [NSURL URLWithString:serviceIP];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        
    
    [request setDelegate:self];
    [request startAsynchronous];
    
}

- (void)requestFinished:(ASIHTTPRequest *)request
{    
    
        NSString *responseString = [request responseString];
    
            NSLog(@"responseString: %@", responseString);
    
        NSDictionary *responseDict = [responseString JSONValue];
    
             NSLog(@"JSONValue: %@", [responseString JSONValue]);
    
    NSArray *songs = [responseDict objectForKey:@"songs"];
    
    int i = 0;
    
    songListData = [[NSMutableArray alloc]init];
    
    for (NSDictionary *song in songs){
        NSDictionary *songHolder = [songs objectAtIndex:i];
        
           NSLog(@"That Song: %@", songHolder);
        
        NSArray *currentSong = [songHolder objectForKey:@"song"];
            NSLog(@"What we get?: %@", currentSong);
        
        NSDictionary *locationHolder = [currentSong objectAtIndex:0];
        NSDictionary *titleHolder = [currentSong objectAtIndex:1];
        NSDictionary *artistHolder = [currentSong objectAtIndex:2];
        
        Song *newSong = [[Song alloc] init];
        
        newSong.location = [locationHolder objectForKey:@"location"];
        NSLog(@"location: %@", [locationHolder objectForKey:@"location"]);
        newSong.songTitle = [titleHolder objectForKey:@"title"];
            NSLog(@"title: %@", [titleHolder objectForKey:@"title"]);
        newSong.artist = [artistHolder objectForKey:@"artist"];
            NSLog(@"artist: %@", [artistHolder objectForKey:@"artist"]);
        
        [songListData addObject:newSong];
        
        i++;
        
        
    }
    
   
    playListData = [[NSMutableArray alloc]init];
    
     [songList reloadData];
    
    NSLog(@"Should be playing and cells should appear");
             
}

- (void)requestFailed:(ASIHTTPRequest *)request
{    
    NSError *error = [request error];
     NSLog(@"error: %@", error);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==songList)
        return [self.songListData count];
    return [self.playListData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView
    cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"Ummm");
    
    if(tableView==songList){
        
    
        static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
        
        SongCell *cell = (SongCell *)[tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
        
        if(cell == nil) {
                    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SongCell" owner:self options:nil];
                    cell = [nib objectAtIndex:0];

                    [cell.addButton addTarget:self action:@selector(addToPlaylist:) forControlEvents:UIControlEventTouchUpInside];
                    
                }
                
                NSUInteger row = [indexPath row];
                cell.songHolder = [songListData objectAtIndex:row];
                [cell.songName setTitle:[[songListData objectAtIndex:row]songTitle] forState:UIControlStateNormal]; 
                [cell.songName addTarget:self action:@selector(playSong:) forControlEvents:UIControlEventTouchUpInside];
                
                cell.songLocation = [[songListData objectAtIndex:row]location];
                
               
                
                return cell;
    }
    
    
            static NSString *PlayListIdentifier = @"PlayListIdentifier";
            PlaylistCell *cell = (PlaylistCell *)[tableView dequeueReusableCellWithIdentifier:PlayListIdentifier];
            
            if(cell == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PlaylistCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
                [cell.removeButton addTarget:self action:@selector(removeFromPlaylist:) forControlEvents:UIControlEventTouchUpInside];
                
            }    
            NSUInteger row = [indexPath row];
    
            cell.songHolder = [playListData objectAtIndex:row];
            cell.songLabel.text = [[playListData objectAtIndex:row] songTitle] ;
                       
            return cell;

    
}

-(void)addToPlaylist:(id)button{
    NSLog(@"WOOOOOOT!");
       
    SongCell *song = (SongCell *)[[[(UIButton *)button superview]superview]superview];
      
    NSIndexPath *indexPath = [self.songList indexPathForCell:song];
    
    
    NSArray *rowToMove = [NSArray arrayWithObject:indexPath];
    
    [self.songList beginUpdates];
    [self.songList deleteRowsAtIndexPaths:rowToMove withRowAnimation:UITableViewRowAnimationRight];
    
    Song *songtoAdd = song.songHolder;
        
    [playListData addObject:songtoAdd];
    
    NSIndexPath *testPath = [NSIndexPath indexPathForRow:(playListData.count-1) inSection:0];
    NSArray *testIndexArray = [NSArray arrayWithObject:testPath];
    
    [self.playlist insertRowsAtIndexPaths:testIndexArray withRowAnimation:UITableViewRowAnimationLeft];
    
    
    NSLog(@"Before %d",songListData.count);
    
    
    [songListData removeObject:songtoAdd];

    
    NSLog(@"After %d",songListData.count);
    
    [self.songList endUpdates];
    
     [mediaPlayer updatePlaylist:playListData];
    
    
}

-(void)removeFromPlaylist:(id)button{
    NSLog(@"WOOOOOOT!");
    
    PlaylistCell *song = (PlaylistCell *)[[(UIButton *)button superview]superview];
       
    NSIndexPath *indexPath = [self.playlist indexPathForCell:song];
    
    
    NSArray *rowToMove = [NSArray arrayWithObject:indexPath];
    
    [self.playlist beginUpdates];
        [self.playlist deleteRowsAtIndexPaths:rowToMove withRowAnimation:UITableViewRowAnimationLeft];
        
        Song *songtoAdd = song.songHolder;
        
         [mediaPlayer removeSong:indexPath.row];
    
        [playListData removeObject:songtoAdd];
    
   [self.playlist endUpdates];
    
    
    [songListData addObject:songtoAdd];
    
    
    [self.songList beginUpdates];
    
    
        NSIndexPath *testPath = [NSIndexPath indexPathForRow:(songListData.count-1) inSection:0];
        NSArray *testIndexArray = [NSArray arrayWithObject:testPath];
        
        [self.songList insertRowsAtIndexPaths:testIndexArray withRowAnimation:UITableViewRowAnimationRight];
    
    [self.songList endUpdates];
    
    NSLog(@"Heresey!! %@", songtoAdd.location);
    
   
    
     [mediaPlayer updatePlaylist:playListData];
    
    
    
    
}

-(void) playSong:(id)songButton{
    
    NSLog(@"The song was clicked on.  Play, durnit!");
    SongCell *song = (SongCell *)[[[(UIButton *)songButton superview]superview]superview];
    
    isPlaying = YES;
    
    [mediaPlayer playSong:song.songLocation];
    
    [self changeImage];
    
}

-(void) changeImage{
    
    UIImage *changeImage;
    
    if (isPlaying){
        changeImage = [UIImage imageNamed:@"pauseButton.png"];
    }
        
    else{
        changeImage = [UIImage imageNamed:@"playButton.png"];
    }
    
    [playButton setImage:changeImage forState:UIControlStateNormal];
    
    
    
}

-(void) songChanged:(NSUInteger)index{
    
    if(isPlaying == NO){
        isPlaying = YES;
        [self changeImage];
    }
    
    [playlist selectRowAtIndexPath:[NSIndexPath indexPathForRow:(index) inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
}

-(void) playerDidFinishPlaying{
    isPlaying = NO;
    playlistPlaying = NO;
    [self changeImage];
}







@end
