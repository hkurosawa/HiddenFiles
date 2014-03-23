//
//  HiddenFiles.h
//  HiddenFiles
//
//  Created by hiroyukik on 2014/03/14.
//  Copyright (c) 2014年 Hiroyuki Kurosawa. All rights reserved.
//

#import <PreferencePanes/PreferencePanes.h>

@interface HiddenFiles : NSPreferencePane
@property (weak) IBOutlet NSButton *cbShowHiddenFiles;

- (void)mainViewDidLoad;
- (IBAction)didCheckboxClicked:(id)sender;
- (void)restartFinder;
@end
