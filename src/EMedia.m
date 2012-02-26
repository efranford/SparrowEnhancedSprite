//
//  EMedia.m
//  Extended Media
//
//  Created by Elliot Franford on 1/16/12.
//  Copyright (c) 2012 Abandon Hope Games, LLC. All rights reserved.
//

#import "EMedia.h"
#import "ESprite.h"

@implementation EMedia

static SPTextureAtlas *atlas = NULL;
static NSMutableDictionary *sounds = NULL;
static SPStage* _stage = NULL;
static SPJuggler* _juggler = NULL;

@synthesize stage = _stage;
@synthesize juggler = _juggler;

#pragma mark Texture Atlas

+ (void)initTextures:(NSString *)atlasFile
{
    [atlas release];
    NSString *atlasLoc = atlasFile;
    atlas = [[SPTextureAtlas alloc] initWithContentsOfFile:atlasLoc];
}
+ (void)releaseTextures
{
    [atlas release];
    atlas = nil;
}

+ (SPTexture *)atlasTexture:(NSString *)name
{
    if (!atlas)
        [NSException raise:NSGenericException format:@"call 'initTextures:' first"];
    return [atlas textureByName:name];
}

+ (NSArray *)texturesStartingWith:(NSString *)name
{
    if (!atlas)
        [NSException raise:NSGenericException format:@"call 'initTextures:' first"];
    return [atlas texturesStartingWith:name];
}

#pragma mark Stage

+ (void)initStage{
    _stage = [[SPStage alloc]init];
    [_stage addEventListener:@selector(onAddToStage:) atObject:self forType:SP_EVENT_TYPE_ADDED_TO_STAGE];
}

+ (void)onAddToStage:(SPEvent*)evt
{
    id obj = [_stage childAtIndex:_stage.numChildren-1];
    
    if([obj isKindOfClass:ESprite.class])
    {
        [_juggler addObject:((ESprite*)obj).currentAnimation];
        NSLog(@"Added %@ to the juggler", ((ESprite*)obj).name);
    }
}

+ (void)releaseStage{
    [_stage release];
    _stage = nil;
}

+ (SPStage*) getStage{
    return _stage;
}

#pragma mark Juggler
+ (void)initJuggler{
    _juggler = [[SPJuggler alloc]init];
}

+ (void)releaseJuggler{
    [_juggler release];
    _juggler = nil;
}

+ (SPJuggler*)getJuggler{
    return _juggler;
}

#pragma mark Audio

+ (void)initAudio
{
    if (sounds) return;
    
    [SPAudioEngine start];
    sounds = [[NSMutableDictionary alloc] init];
    
    // enumerate all sounds
    
    NSString *soundDir = [[NSBundle mainBundle] resourcePath];
    NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager]
                                      enumeratorAtPath:soundDir];   
    
    NSString *filename;
    while (filename = [dirEnum nextObject])
    {
        if ([[filename pathExtension] isEqualToString: @"caf"])
        {
            SPSound *sound = [[SPSound alloc] initWithContentsOfFile:filename];
            SPSoundChannel *channel = [sound createChannel];
            [sounds setObject:channel forKey:filename];
            [sound release];
        }
    }
}

+ (void)releaseAudio
{
    [sounds release];
    sounds = nil;
    [SPAudioEngine stop];
}

+ (void)playSound:(NSString *)soundName
{
    [[sounds objectForKey:soundName] play];
}

+ (SPSoundChannel *)soundChannel:(NSString *)soundName
{
    return [sounds objectForKey:soundName];
}

//960x640    
int RETINA_WIDTH = 640;
int RETINA_HEIGHT = 960;

//320x480
int NORMAL_WIDTH = 320;
int NORMAL_HEIGHT = 480;


@end
