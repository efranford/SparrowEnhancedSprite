//
//  ESpriteManager.m
//  AppScaffold
//
//  Created by Elliot Franford on 1/16/12.
//  Copyright (c) 2012 Abandon Hope Games, LLC. All rights reserved.
//

#import "ESpriteManager.h"

@implementation ESpriteManager

static NSMutableDictionary* _sprites;

@synthesize sprites = _sprites;

+(id) initManager
{
    _sprites = [[NSMutableDictionary alloc]init];
    return self;
}

+(void) addSprite:(ESprite*)sprite withName:(NSString*)name
{
    [_sprites setObject:sprite forKey:name];
}

+(void) removeSpriteWithName:(NSString*)name
{
    ESprite* removeMe = [_sprites objectForKey:name];
    if(removeMe)
    {
        [_sprites removeObjectForKey:name];
    }
    [removeMe dealloc];
}

+(ESprite*) spriteByName:(NSString*)name
{
    return [_sprites objectForKey:name];
}

+(void) setSpriteState:(NSString*)state forSpriteWithName:(NSString*)name
{
    ESprite* sprite = [self spriteByName:name];
    [sprite setStateUsingKey:state];
}

+(void) advanceTime:(double)time
{
    for(NSString* key in _sprites)
    {
        ESprite* sprite = [_sprites valueForKey:key];
        [sprite advanceTime:time];
    }
}

@end
