//
//  Util.m
//  HiddenFiles
//
//  Created by hiroyukik on 2014/03/17.
//  Copyright (c) 2014年 Hiroyuki Kurosawa. All rights reserved.
//

#import "Util.h"

@implementation Util
/**
 * Reference:
 * http://stackoverflow.com/questions/412562/execute-a-terminal-command-from-a-cocoa-app
 */
- (NSString*) runScript:(NSString*)scriptName withBundle:(NSBundle*)bundle
{
    NSTask *task;
    task = [[NSTask alloc] init];
    [task setLaunchPath: @"/bin/sh"];
    
    NSArray *arguments;
    NSString* newpath = [NSString stringWithFormat:@"%@/%@",[bundle resourcePath], scriptName];
    //NSLog(@"shell script path: %@",newpath);
    arguments = [NSArray arrayWithObjects:newpath, nil];
    [task setArguments: arguments];
    
    NSPipe *pipe;
    pipe = [NSPipe pipe];
    [task setStandardOutput: pipe];
    
    NSFileHandle *file;
    file = [pipe fileHandleForReading];
    
    [task launch];
    
    NSData *data;
    data = [file readDataToEndOfFile];
    
    NSString *string;
    string = [[[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding]
              stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSLog (@"script returned:%@", string);
    
    return string;
}
@end
