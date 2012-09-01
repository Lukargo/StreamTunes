//
//  Song.h
//  StreamTunes
//
//  Created by Luke Stevens on 11/22/11.
//  Copyright (c) 2011 Southeast Community College. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Song : NSObject
@property (nonatomic, retain) NSString *songTitle;
@property (nonatomic, retain) NSString *artist;
@property (nonatomic, retain) NSString *location;
@end
