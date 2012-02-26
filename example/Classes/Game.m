//
//  Game.m
//  AppScaffold
//

#import "Game.h" 
#import "ESprite.h"
#import "EMedia.h"

@implementation Game

- (id)initWithWidth:(float)width height:(float)height
{
    if ((self = [super initWithWidth:width height:height]))
    {
        [EMedia initStage];
        [EMedia initJuggler];
        [ESpriteManager initManager];
        
        //[self.juggler copy:[EMedia getJuggler]];
        sprite = [[ESprite alloc]initWithESpriteFile:@"Player.xml" AndInitialAnimation:@"away"];

        [ESpriteManager addSprite:sprite withName:@"Player"];
        
        SPButton *buttonname = [SPButton buttonWithUpState:[SPTexture textureWithContentsOfFile:@"button.png"]];
        
        [buttonname setWidth:100];
        [buttonname setHeight:75];
        [buttonname setText:@"Towards"];
        
        SPButton *buttonAway = [SPButton buttonWithUpState:[SPTexture textureWithContentsOfFile:@"button.png"]];
        
        [buttonAway setWidth:100];
        [buttonAway setHeight:75];
        [buttonAway setText:@"Away"];
        
        [[EMedia getStage] addChild:buttonAway];
        [[EMedia getStage] addChild: buttonname];
        [[EMedia getStage] addChild:sprite];
        
        [buttonname setX:buttonAway.width];
        
        [buttonname addEventListener:@selector(onButtonTriggered:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
        [buttonAway addEventListener:@selector(onAwayButtonTriggered:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];      
        [self addEventListener:@selector(onEnterFrame:) atObject:self
                       forType:SP_EVENT_TYPE_ENTER_FRAME];
        [self addChild:[EMedia getStage]];
    }
    return self;
}

- (void)onButtonTriggered:(SPEvent *)event
{
    [ESpriteManager setSpriteState:@"toward" forSpriteWithName:@"Player"];
}

- (void)onAwayButtonTriggered:(SPEvent *)event
{
    [ESpriteManager setSpriteState:@"away" forSpriteWithName:@"Player"];
}

- (void)onEnterFrame:(SPEnterFrameEvent *)event
{
    double passedTime = event.passedTime;
    [ESpriteManager advanceTime:passedTime];
}
@end
