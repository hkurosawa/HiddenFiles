//
//  HiddenFiles.m
//  HiddenFiles
//
//  Created by hiroyukik on 2014/03/14.
//  Copyright (c) 2014年 Hiroyuki Kurosawa. All rights reserved.
//

#import "HiddenFiles.h"
#import "Util.h"
#import "WindowController.h"

@implementation HiddenFiles
@synthesize w;

- (void)mainViewDidLoad
{

}

- (void)willSelect
{
    // check state for hidden files
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [defaults persistentDomainForName:@"com.apple.finder"];
    if ([[dict objectForKey:@"AppleShowAllFiles"] isEqualToString:@"0"]) {
        [[self cbShowHiddenFiles] setState:NSOffState];
    } else {
        [[self cbShowHiddenFiles] setState:NSOnState];
    }
    
    // check state for Library checkbox
    Util *util = [[Util alloc] init];
    NSString *r = [util runScript:@"CheckLibraryHiddenFlag.sh" withBundle:[NSBundle bundleForClass:NSClassFromString(@"HiddenFiles")]];
    if([r intValue]==0) {
        //NSLog(@"no hidden");
        [[self cbShowLibrary] setState:NSOnState];
    } else {
        //NSLog(@"hidden");
        [[self cbShowLibrary] setState:NSOffState];
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
    //[self restartFinder];
    [self showAlert];
}

- (IBAction)didLibraryCheckboxClicked:(id)sender {
    NSLog(@"clicked: %ld",[sender state]);
    Util *util = [[Util alloc] init];
    if ([sender state]==NSOnState) {
        NSLog(@"current state = on");
        // set to off
        NSString *r = [util runScript:@"ChflagsHiddenLibrary.sh" withBundle:[NSBundle bundleForClass:NSClassFromString(@"HiddenFiles")]];
    } else {
        NSLog(@"current state = off");
        // set to on
        NSString *r = [util runScript:@"ChflagsNoHiddenLibrary.sh" withBundle:[NSBundle bundleForClass:NSClassFromString(@"HiddenFiles")]];
    }
}

- (IBAction)didRestartFinderClicked:(id)sender {
    [self showAlert];
}

- (void)restartFinder
{
    [[NSTask launchedTaskWithLaunchPath:@"/usr/bin/killall" arguments:[NSArray arrayWithObjects:@"Finder", nil]] waitUntilExit];
}

- (void)alertDidEnd:(NSAlert *)alert returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo
{
    switch (returnCode) {
        case NSAlertFirstButtonReturn:
            NSLog(@"OK");
            [self restartFinder];
            break;
        case NSAlertSecondButtonReturn:
            NSLog(@"Cancel");
            break;
        default:
            break;
    }

    NSLog(@"%zd",returnCode);
    
}

- (void)showAlert {
    
    NSAlert *alert = [[NSAlert alloc] init];
    
    [alert addButtonWithTitle:@"OK"];
    
    [alert addButtonWithTitle:@"Not Now"];
    
    [alert setMessageText:@"Restart Finder?"];
    
    [alert setInformativeText:@"Restarting the Finder is needed for this setting change to take effect."];
    
    [alert setAlertStyle:NSInformationalAlertStyle];
    
    
    
    [alert beginSheetModalForWindow:[[self mainView] window] modalDelegate:self didEndSelector:@selector(alertDidEnd:returnCode:contextInfo:) contextInfo:nil];
    
}
@end
