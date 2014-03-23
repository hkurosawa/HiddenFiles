//
//  WindowController.m
//  HiddenFiles
//
//  Created by hiroyukik on 2014/03/17.
//  Copyright (c) 2014年 Hiroyuki Kurosawa. All rights reserved.
//

#import "WindowController.h"

@interface WindowController ()

@end

@implementation WindowController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (IBAction)didOKClicked:(id)sender {
    NSLog(@"OK clicked");
    [NSApp stopModalWithCode:1];
    [[self window]close];
}

- (IBAction)didCancelClicked:(id)sender {
    NSLog(@"Cancel clicked");
    [NSApp stopModalWithCode:0];
    [[self window]close];
}

@end
