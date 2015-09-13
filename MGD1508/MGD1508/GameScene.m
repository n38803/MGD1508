//
//  GameScene.m
//  MobileGame
//
//  Created by Shaun Thompson on 8/6/15.
//  Copyright (c) 2015 Shaun Thompson. All rights reserved.
//

#import "GameScene.h"
#import "GameOverScene.h"

@implementation GameScene

static const int heroCategory       =  1 << 0;
static const int worldCategory      =  1 << 1;
static const int enemyCategory      =  1 << 2;
static const int foodCategory       =  1 << 3;

CGRect screenRect;
CGFloat screenHeight;
CGFloat screenWidth;
float screenScale;
float tinyScale;

SKLabelNode *scoreNode;
SKSpriteNode *bones;
NSInteger *score;

// Init function
-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        
        //self.physicsWorld.gravity = CGVectorMake(0,0);
        //self.physicsWorld.contactDelegate = self;
        
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
    //bgImage.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
    bgImage.zPosition = -50;
    [bgImage setScale:0.75/screenScale];
    [self addChild:bgImage];

    

    // Pause Label
    _pause = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    _pause.text = @"[ Pause ]";
    _pause.zPosition = 100;
    _pause.name = @"Pause";
    [_pause setScale:1.0*screenScale];
    _pause.fontColor = [UIColor redColor];
    _pause.fontSize = 25;
    _pause.position = CGPointMake(100, 700);

    [self addChild:_pause];
    
    
    // Score Label
    score = 0;
    scoreNode = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    //scoreNode.position = CGPointMake( CGRectGetMidX( self.frame ), 3 * self.frame.size.height / 4 );
    scoreNode.position = CGPointMake(900, 700);
    scoreNode.zPosition = 100;
    [scoreNode setScale:1.0*screenScale];
    scoreNode.fontColor = [UIColor redColor];
    scoreNode.text = [NSString stringWithFormat:@"SCORE: %ld", (long)score];
    [self addChild:scoreNode];
    
    
    // Create main character texture
    SKTexture* h1Texture = [SKTexture textureWithImageNamed:@"cRun1"];
    h1Texture.filteringMode = SKTextureFilteringNearest;
    SKTexture* h2Texture = [SKTexture textureWithImageNamed:@"crun2"];
    h2Texture.filteringMode = SKTextureFilteringNearest;

    // Main character node assignment & physics body
    _hero = [SKSpriteNode spriteNodeWithTexture:h1Texture];
    [_hero setScale:1.0*screenScale];
    _hero.name = @"hero";
    _hero.position = CGPointMake(CGRectGetMidX(self.frame),
                                CGRectGetMidY(self.frame));
    
    _hero.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_hero.size];
    _hero.physicsBody.dynamic = YES;
    _hero.physicsBody.allowsRotation = NO;
    _hero.physicsBody.categoryBitMask = heroCategory;
    _hero.physicsBody.collisionBitMask = worldCategory | enemyCategory | foodCategory;
    _hero.physicsBody.contactTestBitMask = worldCategory |  enemyCategory | foodCategory;
    _hero.physicsBody.usesPreciseCollisionDetection = YES;

    
    [self addChild:_hero];
    
    // Animate hero movement
    SKAction* run = [SKAction repeatActionForever:[SKAction animateWithTextures:@[h1Texture, h2Texture] timePerFrame:0.2]];
    [_hero runAction:run];
    
    // Fish sprite node assignment & physics body
    SKSpriteNode *fish = [SKSpriteNode spriteNodeWithImageNamed:@"Fish"];
    [fish setScale:0.35*screenScale];
    fish.name = @"fish";
    
    fish.position = CGPointMake((CGRectGetMidX(self.frame)-100),
                                CGRectGetMidY(self.frame));
    
    fish.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:fish.size];
    fish.physicsBody.dynamic = YES;
    fish.physicsBody.allowsRotation = NO;
    fish.physicsBody.categoryBitMask = foodCategory;
    
    fish.physicsBody.contactTestBitMask = heroCategory;
    fish.physicsBody.usesPreciseCollisionDetection = YES;

    [self addChild:fish];

    bones = [SKSpriteNode spriteNodeWithImageNamed:@"eatenfish"];
    [bones setScale:0.15*screenScale];
    bones.name = @"bones";
    
    bones.position = CGPointMake((CGRectGetMidX(self.frame)-100),
                                CGRectGetMidY(self.frame));
    
    bones.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bones.size];
    bones.physicsBody.dynamic = NO;
    bones.physicsBody.allowsRotation = NO;
    //bones.physicsBody.categoryBitMask = enemyCategory;
    //bones.physicsBody.contactTestBitMask = heroCategory;
    bones.physicsBody.usesPreciseCollisionDetection = YES;
    
    
    // Enemy Bee sprite node assignment & physics body
    _bee = [SKSpriteNode spriteNodeWithImageNamed:@"Bee"];
    [_bee setScale:0.5*screenScale];
    _bee.name = @"bee";
    _bee.position = CGPointMake((CGRectGetMidX(self.frame)+100),
                               CGRectGetMidY(self.frame));
    _bee.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_bee.size];
    _bee.physicsBody.dynamic = NO;
    _bee.physicsBody.allowsRotation = NO;
    _bee.physicsBody.categoryBitMask = enemyCategory;
    _bee.physicsBody.contactTestBitMask = heroCategory;
    fish.physicsBody.usesPreciseCollisionDetection = YES;
    
    
    [self addChild:_bee];
    
    
    // Ground Image
    SKTexture* gTexture = [SKTexture textureWithImageNamed:@"brick"];
    gTexture.filteringMode = SKTextureFilteringNearest;
    
    // Create action to simulate ground movement
    SKAction* gMovement = [SKAction moveByX:-gTexture.size.width*2 y:0 duration:0.02 * gTexture.size.width*2];
    SKAction* gReset    = [SKAction moveByX:gTexture.size.width*2 y:0 duration:0];
    SKAction* gSequence = [SKAction repeatActionForever:[SKAction sequence:@[gMovement, gReset]]];

    // Set loop to duplicate node texture in order to create platform
    for( int i = 0; i < 2 + self.frame.size.width / ( gTexture.size.width * 2 ); ++i ) {
        
        SKSpriteNode* ground = [SKSpriteNode spriteNodeWithTexture:gTexture];
        
        [ground setScale:2.0];
        
        ground.position = CGPointMake(i * ground.size.width, ground.size.height / 2);
        
        
        [ground runAction:gSequence];
        
        [self addChild:ground];
    }
    
    // Create ground node for physics and collisions
    SKNode* groundNode = [SKNode node];
    groundNode.name = @"Ground";
    groundNode.position = CGPointMake(00, gTexture.size.height);
    groundNode.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.frame.size.width, gTexture.size.height * 2)];
    groundNode.physicsBody.dynamic = NO;
    groundNode.physicsBody.categoryBitMask = worldCategory;
    groundNode.physicsBody.contactTestBitMask = heroCategory;
    fish.physicsBody.usesPreciseCollisionDetection = YES;
    [self addChild:groundNode];
    
    
    // Backdrop Image
    SKTexture* sTexture = [SKTexture textureWithImageNamed:@"skyline"];
    sTexture.filteringMode = SKTextureFilteringNearest;
    
    // Create action to simulate backdrop movement
    SKAction* sMovement = [SKAction moveByX:-sTexture.size.width*2 y:0 duration:0.1 * sTexture.size.width*2];
    SKAction* sReset    = [SKAction moveByX:sTexture.size.width*2 y:0 duration:0];
    SKAction* sSequence = [SKAction repeatActionForever:[SKAction sequence:@[sMovement, sReset]]];
    
    
    for( int i = 0; i < 2 + self.frame.size.width / ( sTexture.size.width * 2 ); ++i ) {
        SKSpriteNode* backdrop = [SKSpriteNode spriteNodeWithTexture:sTexture];
        [backdrop setScale:1.0*screenScale];
        backdrop.zPosition = -20;
        backdrop.alpha = 0.35;
        backdrop.position = CGPointMake(i * backdrop.size.width, backdrop.size.height / 2 + gTexture.size.height * 2);
        [backdrop runAction:sSequence];
        [self addChild:backdrop];
    }
    
    // Randomized Cloads
    SKTextureAtlas *cloudsAtlas = [SKTextureAtlas atlasNamed:@"Clouds"];
    NSArray *textureNamesClouds = [cloudsAtlas textureNames];
    _cTextures = [NSMutableArray new];
    for (NSString *name in textureNamesClouds) {
        SKTexture *texture = [cloudsAtlas textureNamed:name];
        [_cTextures addObject:texture];
    }
    
    [self clouds];
    
    
    
    self.physicsWorld.gravity = CGVectorMake(0,0);
    self.physicsWorld.contactDelegate = self;
    
     // load sound files to ensure no lag during gameplay
    [SKAction playSoundFileNamed:@"eating.mp3" waitForCompletion:NO];
    [SKAction playSoundFileNamed:@"glub.mp3" waitForCompletion:NO];
    [SKAction playSoundFileNamed:@"grunt.mp3" waitForCompletion:NO];
    [SKAction playSoundFileNamed:@"insect.mp3" waitForCompletion:NO];
    
    
}

-(void)clouds{
    
    int randomClouds = (arc4random() % 1);
    if(randomClouds == 1){
        
        int whichCloud = (arc4random() % 3);
        SKSpriteNode *cloud = [SKSpriteNode spriteNodeWithTexture:[_cTextures objectAtIndex:whichCloud]];
        int randomYAxix = (arc4random() % 300);
        cloud.position = CGPointMake(screenRect.size.height+cloud.size.height/2, randomYAxix);
        cloud.zPosition = 1;
        [cloud setScale: 2.0];
        int randomTimeCloud = (arc4random() % 1);
        
        SKAction *move =[SKAction moveTo:CGPointMake(0-cloud.size.height, randomYAxix) duration:randomTimeCloud];
        SKAction *remove = [SKAction removeFromParent];
        [cloud runAction:[SKAction sequence:@[move,remove]]];
        [self addChild:cloud];
    }
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self clouds];
    

    /* Called when a touch begins */
    for (UITouch *touch in touches) {
        
        
        // define location of user touch
        _touchLocation = [touch locationInNode:self];

        // determine if user touch is equivelant to node location
        SKNode *node = [self nodeAtPoint:_touchLocation];

        
        // run sound or action with corresponding with appropriate node
        if ([node.name isEqualToString:@"hero"]) {
            [node runAction:[SKAction playSoundFileNamed:@"grunt.mp3" waitForCompletion:NO]];
            
        }
        else if ([node.name isEqualToString:@"fish"]){
            [node runAction:[SKAction playSoundFileNamed:@"glub.mp3" waitForCompletion:NO]];

        }
        else if ([node.name isEqualToString:@"bee"]){
            [node runAction:[SKAction playSoundFileNamed:@"insect.mp3" waitForCompletion:NO]];
        }
        else if ([node.name isEqualToString:@"Pause"]){
            if (self.scene.view.paused == YES){
                self.scene.view.paused = NO;
            }
            else if(self.scene.view.paused == NO){
                self.scene.view.paused = YES;
            }
        }

        
        // Move bees based on user input
        SKAction *heroMove = [SKAction moveTo:_touchLocation duration:2];
        [_hero runAction:heroMove];
        
        

    }  
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        // unpause game
        
        self.scene.view.paused = NO;
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    _bee.physicsBody.velocity=CGVectorMake(200, 200);
}

/*
- (void)addCollisionWallAtWorldPoint:(CGPoint)worldPoint withWidth:(CGFloat)width height:(CGFloat)height {
    // Create a rectangle with the specified size, and a basic node
    wallNode.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:rect.size];
    wallNode.physicsBody.dynamic = NO;
    wallNode.physicsBody.categoryBitMask = APAColliderTypeWall;
}
*/





- (void)didBeginContact:(SKPhysicsContact *)contact
{
    // print out collision points
    NSLog(@"Body A: %@ contacting Body B: %@",contact.bodyA.node.name, contact.bodyB.node.name);

    // assign secondary collision point to a node
    SKNode *node = contact.bodyB.node;
    
    if(contact.bodyA.categoryBitMask == foodCategory || contact.bodyB.categoryBitMask == foodCategory)
    {
        
        [self addChild:bones];
        // Play sound, provide visual feedback, and remove node of player collision
        [self runAction: [SKAction playSoundFileNamed:@"eating.mp3" waitForCompletion:NO]];
        score++;
        scoreNode.text = [NSString stringWithFormat:@"SCORE: %ld", (long)score];
        [node removeFromParent];
        
        // pause scene
        self.scene.view.paused = YES;
        
        // Display narrative as alertview
        UIAlertView *dialogue =    [[UIAlertView alloc]
                                    initWithTitle:nil
                                    message:@"Mmm... fish are good."
                                    delegate:self
                                    cancelButtonTitle: @"continue"
                                    otherButtonTitles:nil];
        [dialogue show];
        
        
    }
    
    else if(contact.bodyA.categoryBitMask == enemyCategory || contact.bodyB.categoryBitMask == enemyCategory)
    {
        // Play sound
        [self runAction: [SKAction playSoundFileNamed:@"grunt.mp3" waitForCompletion:NO]];
        NSLog(@"Player collided with Enemy");
        
        
        // Transition to GameOver Scene
        SKScene *gameOver = [[GameOverScene alloc] initWithSize:self.size];
        SKTransition *transition = [SKTransition doorsCloseHorizontalWithDuration:0.5];
        [self.view presentScene:gameOver transition:transition];
        
    }
    
    else if(contact.bodyA.categoryBitMask == worldCategory || contact.bodyB.categoryBitMask == worldCategory)
    {
        // detect node of collision, play sound, and remove node
        SKNode *node = contact.bodyB.node;
        [self runAction: [SKAction playSoundFileNamed:@"grunt.mp3" waitForCompletion:NO]];
        [node removeFromParent];
        
    }
    /*
    else if(CGPointEqualToPoint(_touchLocation, node.position)){
        // run sound or action with corresponding with appropriate node
        if ([node.name isEqualToString:@"hero"]) {
            [node runAction:[SKAction playSoundFileNamed:@"grunt.mp3" waitForCompletion:NO]];
            
        }
        else if ([node.name isEqualToString:@"fish"]){
            [node runAction:[SKAction playSoundFileNamed:@"glub.mp3" waitForCompletion:NO]];
        }
        else if ([node.name isEqualToString:@"bee"]){
            [node runAction:[SKAction playSoundFileNamed:@"insect.mp3" waitForCompletion:NO]];
        }
    }
     */
    
}

@end
