//
//  HiddenFiles.m
//  HiddenFiles
//
//  Created by hiroyukik on 2014/03/14.
//  Copyright (c) 2014年 Hiroyuki Kurosawa. All rights reserved.
//

#import "HiddenFiles.h"
#import "Util.h"

@implementation HiddenFiles

- (void)mainViewDidLoad
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [defaults persistentDomainForName:@"com.apple.finder"];
    if ([[dict objectForKey:@"AppleShowAllFiles"] isEqualToString:@"0"]) {
        [[self cbShowHiddenFiles] setState:NSOffState];
    } else {
        [[self cbShowHiddenFiles] setState:NSOnState];
    }
}

- (IBAction)didCheckboxClicked:(id)sender
{
    //sets the UserDefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [defaults persistentDomainForName:@"com.apple.finder"];
    NSMutableDictionary *newDict = [dict mutableCopy];
    if ([[newDict objectForKey:@"AppleShowAllFiles"] isEqualToString:@"0"]) {
        [newDict setObject:@"1" forKey:@"AppleShowAllFiles"];
    } else {
        [newDict setObject:@"0" forKey:@"AppleShowAllFiles"];
    }
    [defaults setPersistentDomain:newDict forName:@"com.apple.finder"];
    [defaults synchronize];
    
    //quit the Finder. it will be relaunched automatically
    [self restartFinder];
}

- (void)restartFinder
{
    //NSAppleScript *restartFinder = [[NSAppleScript alloc] initWithSource:@"tell application \"Finder\" to quit"];
    //[restartFinder executeAndReturnError:nil];
    //[NSApp runModalForWindow:];
    //[[NSTask launchedTaskWithLaunchPath:@"/usr/bin/killall" arguments:[NSArray arrayWithObjects:@"Finder", nil]] waitUntilExit];
    //[[NSTask alloc] init]
    Util *util = [[Util alloc] init];
    [util runScript:@"RelaunchFinder.sh" withBundle:[NSBundle bundleForClass:NSClassFromString(@"HiddenFiles")]];
    NSLog(@"%@",[util runScript:@"Script.sh" withBundle:[NSBundle bundleForClass:NSClassFromString(@"HiddenFiles")]]);
    
}
@end
