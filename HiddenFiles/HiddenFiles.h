//
//  HiddenFiles.h
//  HiddenFiles
//
//  Created by hiroyukik on 2014/03/14.
//  Copyright (c) 2014年 Hiroyuki Kurosawa. All rights reserved.
//

#import <PreferencePanes/PreferencePanes.h>
#import "WindowController.h"

@interface HiddenFiles : NSPreferencePane
@property (weak) IBOutlet NSButton *cbShowHiddenFiles;
@property (weak) IBOutlet NSButton *cbShowLibrary;
@property WindowController *w;

- (void)mainViewDidLoad;
- (IBAction)didCheckboxClicked:(id)sender;
- (IBAction)didLibraryCheckboxClicked:(id)sender;
- (IBAction)didRestartFinderClicked:(id)sender;
- (void)restartFinder;
@end
