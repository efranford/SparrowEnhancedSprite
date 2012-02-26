//
//  ESpriteState.m
//  AppScaffold
//
//  Created by Elliot Franford on 1/16/12.
//  Copyright (c) 2012 Abandon Hope Games, LLC. All rights reserved.
//

#import "ESpriteState.h"

@implementation ESpriteState

@synthesize stateName = mStateName;
@synthesize animationFPS = mAnimationFPS;
@synthesize animationPrefix = mAnimationPrefix;
@synthesize loop = mLoop;

- (id) init{
    if([super init])
    {
        mStateName = [[NSString alloc]init];
        mAnimationPrefix = [[NSString alloc]init];
        mAnimationFPS = 0;
    }
    return self;
}

- (id) initWithName:(NSString*)name prefix:(NSString*)prefix fps:(int)fps loop:(BOOL)loop{
    if([super init])
    {
        mStateName = [[NSString alloc]initWithString:name];
        mAnimationPrefix = [[NSString alloc]initWithString:prefix];
        mAnimationFPS = fps;
        mLoop = loop;
    }
    return self;
}
@end
