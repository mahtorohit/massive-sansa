//
//  TDViewController.h
//  Grid
//
//  Created by mahmuzic on 20.02.13.
//  Copyright (c) 2013 tum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuItem.h"
#import "TDTreeItemView.h"
#import <AVFoundation/AVFoundation.h>
#import "IDPTaskProvider.h"

@interface TDViewController : UIViewController<TDTreeItemProtocol, MenuCandidate> {
    AVAudioPlayer *audioPlayer;
}

@property (nonatomic, retain) MenuItem *rootMenuItem;
@property (nonatomic, retain) TDTreeItemView *rootItemView;

@end
