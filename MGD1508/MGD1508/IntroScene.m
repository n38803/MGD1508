//
//  IntroScene.m
//  Doodle World
//
//  Created by Shaun Thompson on 9/12/15.
//  Copyright (c) 2015 Shaun Thompson. All rights reserved.
//

#import "IntroScene.h"
#import "GameScene.h"

@implementation IntroScene


CGRect screenRect;
CGFloat screenHeight;
CGFloat screenWidth;
float screenScale;

// Init function
-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
    }
    return self;
}

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    
    // Grab screen parameters
    screenRect = [[UIScreen mainScreen] bounds];
    screenHeight = screenRect.size.height;
    screenWidth = screenRect.size.width;
    NSLog(@"Screen Height: %f", screenHeight);
    NSLog(@"Screen Width: %f", screenWidth);
    screenScale = (screenHeight/768);
    NSLog(@"Screen Scale: %f", screenScale);
    
    
    // Background image
    SKSpriteNode *bgImage = [SKSpriteNode spriteNodeWithImageNamed:@"paperbackground"];
    bgImage.position = CGPointMake(self.size.width/2, self.size.height/2);
    bgImage.zPosition = -50;
    [bgImage setScale:0.75/screenScale];
    [self addChild:bgImage];
    
    
    
    // Story Portrait 1
    SKSpriteNode *scene1 = [SKSpriteNode spriteNodeWithImageNamed:@"Storyline1"];
    [scene1 setScale:0.8*screenScale];
    scene1.name = @"scene1";
    scene1.zPosition = 0;
    
    scene1.position = CGPointMake((CGRectGetMidX(self.frame)),
                                CGRectGetMidY(self.frame)+150);
    
    // Story captions for portrait 1
    SKLabelNode *caption1 = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    caption1.fontSize = 25;
    caption1.position = CGPointMake(370, 225);
    caption1.name = @"caption1";
    caption1.fontColor = [UIColor blackColor];
    caption1.text = @"Stix had lived a calm, boring, and pretty lonely existence";
    
    SKLabelNode *caption2 = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    caption2.fontSize = 25;
    caption2.position = CGPointMake(380, 205);
    caption2.name = @"caption2";
    caption2.fontColor = [UIColor blackColor];
    caption2.text = @"... until he found the love of his life, Stickly.";
    
    SKLabelNode *caption3 = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    caption3.fontSize = 25;
    caption3.position = CGPointMake(500, 195);
    caption3.name = @"caption3";
    caption3.fontColor = [UIColor blackColor];
    caption3.text = @"Stix & Stickly were the happiest hand drawn creatures on earth!";
    
    
    
    // Story Portrait 2
    SKSpriteNode *scene2 = [SKSpriteNode spriteNodeWithImageNamed:@"Storyline2"];
    [scene2 setScale:0.8*screenScale];
    scene2.name = @"scene2";
    scene2.zPosition = 0;
    
    scene2.position = CGPointMake((CGRectGetMidX(self.frame)),
                                  CGRectGetMidY(self.frame)+150);
    
    // Story captions for portrait 2
    SKLabelNode *caption4 = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    caption4.fontSize = 25;
    caption4.position = CGPointMake(370, 225);
    caption4.name = @"caption4";
    caption4.fontColor = [UIColor blackColor];
    caption4.text = @"Then some Ninja showed up & dragon kicked Stix in the face,";
    
    SKLabelNode *caption5 = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    caption5.fontSize = 25;
    caption5.position = CGPointMake(400, 195);
    caption5.name = @"caption5";
    caption5.fontColor = [UIColor blackColor];
    caption5.text = @"grabbed Stickly, and just took off into the wilderness!";
    
    SKLabelNode *caption6 = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    caption6.fontSize = 25;
    caption6.position = CGPointMake(380, 225);
    caption6.name = @"caption6";
    caption6.fontColor = [UIColor blackColor];
    caption6.text = @"And so our hero's story began ...";
    
    
    
    SKLabelNode *skip = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    skip.text = @"[ Skip ]";
    skip.zPosition = 1;
    skip.name = @"skip";
    [skip setScale:1.0*screenScale];
    skip.fontColor = [UIColor redColor];
    skip.fontSize = 22;
    skip.position = CGPointMake(100, 700);
    
    [self addChild:skip];
    
    // Map
    SKSpriteNode *map = [SKSpriteNode spriteNodeWithImageNamed:@"map"];
    [map setScale:0.8*screenScale];
    map.name = @"map";
    map.zPosition = 0;
    
    map.position = CGPointMake((CGRectGetMidX(self.frame)),
                                  CGRectGetMidY(self.frame));
    
    
    // Automate story via time delay
    double cap1delay = 5.0;
    double cap2delay = 10.0;
    double cap3delay = 15.0;
    double cap4delay = 20.0;
    double cap5delay = 25.0;
    double cap6delay = 30.0;
    double mapDelay = 35.0;
    double sceneDelay = 50.0;
    
    dispatch_time_t cap1 = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(cap1delay * NSEC_PER_SEC));
    dispatch_after(cap1, dispatch_get_main_queue(), ^(void){

        [self addChild:scene1];
        [self addChild:caption1];
        
    });
    
    dispatch_time_t cap2 = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(cap2delay * NSEC_PER_SEC));
    dispatch_after((cap2), dispatch_get_main_queue(), ^(void){
        
        [caption1 removeFromParent];
        [self addChild:caption2];
        
    });
    
    dispatch_time_t cap3 = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(cap3delay * NSEC_PER_SEC));
    dispatch_after((cap3), dispatch_get_main_queue(), ^(void){
        
        [caption2 removeFromParent];
        [self addChild:caption3];
        
    });
    
    dispatch_time_t cap4 = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(cap4delay * NSEC_PER_SEC));
    dispatch_after((cap4), dispatch_get_main_queue(), ^(void){
        
        [caption3 removeFromParent];
        [scene1 removeFromParent];
        [self addChild:scene2];
        [self addChild:caption4];
        
    });
    
    
    dispatch_time_t cap5 = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(cap5delay * NSEC_PER_SEC));
    dispatch_after((cap5), dispatch_get_main_queue(), ^(void){
        
        [caption4 removeFromParent];
        [self addChild:caption5];
        
    });
    
    dispatch_time_t cap6 = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(cap6delay * NSEC_PER_SEC));
    dispatch_after((cap6), dispatch_get_main_queue(), ^(void){
        
        [caption5 removeFromParent];
        [self addChild:caption6];
        
    });
    
    dispatch_time_t mapDisplay = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(mapDelay * NSEC_PER_SEC));
    dispatch_after((mapDisplay), dispatch_get_main_queue(), ^(void){
        
        [caption6 removeFromParent];
        [scene2 removeFromParent];
        [self addChild:map];
        
    });
    
    
    dispatch_time_t sceneChange = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(sceneDelay * NSEC_PER_SEC));
    dispatch_after((sceneChange), dispatch_get_main_queue(), ^(void){
        
        SKScene *gameScene = [[GameScene alloc] initWithSize:self.size];
        SKTransition *transition = [SKTransition doorsCloseHorizontalWithDuration:0.5];
        [self.view presentScene:gameScene transition:transition];
        
    });
    

    
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqualToString:@"skip"]) {
        NSLog(@"skip pressed");
        
        SKScene *gameScene = [[GameScene alloc] initWithSize:self.size];
        SKTransition *transition = [SKTransition doorsCloseHorizontalWithDuration:0.5];
        [self.view presentScene:gameScene transition:transition];
    }
    
    
    
        
        
    
}



@end
