//
//  AHGPlayer.m
//  Sparrow
//
//  Created by Elliot Franford on 1/16/12.
//  Copyright (c) 2012 Abandon Hope Games, LLC. All rights reserved.
//

#import "ESprite.h"

@implementation ESprite

@synthesize stateAnimationDictionary;
@synthesize currentAnimation;
@synthesize spriteAtlasFile;
@synthesize currentState;
@synthesize juggler;

NSString* currentElementName;

- (id)initWithESpriteFile:(NSString*)file {
    self = [super init];
    if(self){
         return [self initWithESpriteFile:file AndInitialAnimation:[[NSString alloc]initWithString:@"NoDefault"]];
    }
   else
       return self;
}

- (id)initWithESpriteFile:(NSString*)file AndInitialAnimation:(NSString*)initialAnimation{
    self = [super init];
    if (self) {
        juggler = [[SPJuggler alloc]init];
        stateAnimationDictionary = [[NSMutableDictionary alloc]init];
        [self parseTMXXml:file];   
        
        if([spriteAtlasFile isEqualToString:@""])
            return nil;
        
        [EMedia initTextures:spriteAtlasFile];
        
        if(stateAnimationDictionary.count == 0)
            return nil;
        
        ESpriteState* startState = [self getFirstAnimation];
        
        if([initialAnimation isEqualToString:@"NoDefault"])
            startState = [self getFirstAnimation];
        else
            startState = (ESpriteState*)[stateAnimationDictionary objectForKey:initialAnimation];
        
        if([initialAnimation isEqualToString:@"NoAnimation"])
            return nil;
        
        [self changeState:startState];
    }
    return self;
}

- (ESpriteState*) getFirstAnimation
{
    ESpriteState* state = [[ESpriteState alloc]initWithName:@"NoAnimation" prefix:@"" fps:0 loop:FALSE];
    if(stateAnimationDictionary.count > 0)
    {
        NSString* key = [[stateAnimationDictionary allKeys]objectAtIndex:0];
        state = (ESpriteState*)[stateAnimationDictionary valueForKey:key];
    }
    return state;
}

- (void)parseTMXXml:(NSString *)path
{
    if (!path) return;
    
    float scaleFactor = [SPStage contentScaleFactor];
    NSString* mPath = [[SPUtils absolutePathToFile:path withScaleFactor:scaleFactor] retain];    
    if (!mPath) [NSException raise:SP_EXC_FILE_NOT_FOUND format:@"file not found: %@", path];
    
    SP_CREATE_POOL(pool);
    
    NSData *xmlData = [[NSData alloc] initWithContentsOfFile:mPath];
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:xmlData];
    [xmlData release];
    
    xmlParser.delegate = self;    
    BOOL success = [xmlParser parse];
    
    SP_RELEASE_POOL(pool);
    
    if (!success)    
        [NSException raise:SP_EXC_FILE_INVALID 
                    format:@"could not parse texture atlas %@. Error code: %d, domain: %@", 
         path, xmlParser.parserError.code, xmlParser.parserError.domain];
    
    [xmlParser release];    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName 
    attributes:(NSDictionary *)attributeDict 
{
    currentElementName = [elementName copy];
    if ([currentElementName isEqualToString:@"ESprite"])
    {
        [self setName:[attributeDict valueForKey:@"name"]];
        spriteAtlasFile = [[NSString alloc] initWithString:[attributeDict valueForKey:@"spriteAtlas"]];
    }
    if ([currentElementName isEqualToString:@"State"]) {
        //State name="idle" anmationPrefix="away_" animationFPS="10"
        NSString* stateName = [attributeDict valueForKey:@"name"];
        NSString* animPrefix = [attributeDict valueForKey:@"animationPrefix"];
        int fps = [[attributeDict valueForKey:@"animationFPS"]intValue];
        BOOL loop = [[attributeDict valueForKey:@"loop"]boolValue];
        ESpriteState* state = [[ESpriteState alloc]initWithName:stateName prefix:animPrefix fps:fps loop:loop];
        [stateAnimationDictionary setObject:state forKey:stateName];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
   // intentinoaly not handled right now
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    // intentinoaly not handled right now
}


-(id)getAnimation{
    return currentAnimation;
}

-(void)onMoveSprite:(SPEvent*)evt:(float)speed:(float)angle{
  /*
           0
    -45  .---.  45
        /  |  \
    -90 ---|---  90
        \  |  /
   -135  '---'  135
       -180|180
   */ 
    //NSLog(@"a:%f s:%f",angle,speed);
    float scale_x;
    float scale_y;
    float fAngle = SP_D2R(angle);
    scale_y = cos(fAngle);
    scale_x = sin(fAngle);

    //NSLog(@"sx: %f sy: %f s:%f",scale_x,scale_y,speed);
    float v_x,v_y;
    if(speed > 0){
        v_x = (speed) * scale_x;
        v_y = (speed) * scale_y;
    }
    else
    {
        v_x = (speed * scale_x);
        v_y = (speed * scale_y);
    }
    //NSLog(@"vx: %f vy: %f",v_x,v_y);
    //NSLog(@"x: %f y: %f",self.x,self.y);
    //NSLog(@"X: %f Y: %f",self.x+v_x,self.y+v_y);
    self.x += v_x;
    self.y -= v_y;
}


-(void)setSpritePositionX:(int)x Y:(int)y{
    self.x = x;
    self.y = y;
}


- (void)setState:(ESpriteState*)state
{
    currentState = state;
    [self changeState:state];
} 

- (void)setStateUsingKey:(NSString*)key
{
    [self changeState:[stateAnimationDictionary objectForKey:key]];
} 

- (void) changeState:(ESpriteState*)state
{
    currentState = state;
    // create movie clip
    NSArray *animation = [EMedia texturesStartingWith:state.animationPrefix];
    currentAnimation = [[SPMovieClip alloc] initWithFrames:animation fps:state.animationFPS];
    [currentAnimation setLoop:state.loop];
    [currentAnimation play];
    [self removeAllChildren];
    [self addChild:currentAnimation];
}


- (void)advanceTime:(double)time
{
    [juggler removeAllObjects];
    [juggler addObject:currentAnimation];
    [juggler advanceTime:time];
}

@end
