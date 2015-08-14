//
//  GameScene.m
//  MobileGame
//
//  Created by Shaun Thompson on 8/6/15.
//  Copyright (c) 2015 Shaun Thompson. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

static const int heroCategory      =  1 << 0;
static const int worldCategory     =  1 << 1;
static const int enemyCategory     =  1 << 2;

// Init function
-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        
        self.physicsWorld.gravity = CGVectorMake(0,0);
        self.physicsWorld.contactDelegate = self;
        
    }
    return self;
}


-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    
    // Background image
    SKSpriteNode *bgImage = [SKSpriteNode spriteNodeWithImageNamed:@"paperbackground"];
    bgImage.position = CGPointMake(self.size.width/2, self.size.height/2);
    bgImage.xScale = 1;
    bgImage.yScale = 1;
    [self addChild:bgImage];
    
    /*
    // title on screen (this was a test, will be removed in alpha version)
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    myLabel.text = @"It's Sticks!";
    myLabel.fontSize = 45;
    myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                   (CGRectGetMidY(self.frame)+100));
    [self addChild:myLabel];
     */
    
    
    // Create main character texture
    SKTexture* h1Texture = [SKTexture textureWithImageNamed:@"cRun1"];
    h1Texture.filteringMode = SKTextureFilteringNearest;
    SKTexture* h2Texture = [SKTexture textureWithImageNamed:@"crun2"];
    h2Texture.filteringMode = SKTextureFilteringNearest;

    // Main character node assignment & physics body
    _hero = [SKSpriteNode spriteNodeWithTexture:h1Texture];
    _hero.xScale = 1;
    _hero.yScale = 1;
    _hero.name = @"hero";
    _hero.position = CGPointMake(CGRectGetMidX(self.frame),
                                CGRectGetMidY(self.frame));
    
    _hero.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_hero.size];
    _hero.physicsBody.dynamic = YES;
    _hero.physicsBody.allowsRotation = NO;
    _hero.physicsBody.categoryBitMask = heroCategory;
    _hero.physicsBody.collisionBitMask = worldCategory | enemyCategory;
    _hero.physicsBody.contactTestBitMask = worldCategory |  enemyCategory;
    _hero.physicsBody.usesPreciseCollisionDetection = YES;

    
    [self addChild:_hero];
    
    // Animate hero movement
    SKAction* run = [SKAction repeatActionForever:[SKAction animateWithTextures:@[h1Texture, h2Texture] timePerFrame:0.2]];
    [_hero runAction:run];
    
    // Enemy fish sprite node assignment & physics body
    SKSpriteNode *fish = [SKSpriteNode spriteNodeWithImageNamed:@"Fish"];
    fish.xScale = .35;
    fish.yScale = .35;
    fish.name = @"fish";
    
    fish.position = CGPointMake((CGRectGetMidX(self.frame)-100),
                                CGRectGetMidY(self.frame));
    
    fish.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:fish.size];
    fish.physicsBody.dynamic = YES;
    fish.physicsBody.allowsRotation = NO;
    fish.physicsBody.categoryBitMask = enemyCategory;
    fish.physicsBody.contactTestBitMask = heroCategory;
    fish.physicsBody.usesPreciseCollisionDetection = YES;

    
    
    [self addChild:fish];
    
    // Enemy Bee sprite node assignment & physics body
    _bee = [SKSpriteNode spriteNodeWithImageNamed:@"Bee"];
    _bee.xScale = 0.5;
    _bee.xScale = 0.5;
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
    
    
    
    self.physicsWorld.gravity = CGVectorMake(0,0);
    self.physicsWorld.contactDelegate = self;
    
     // load sound files to ensure no lag during gameplay
    [SKAction playSoundFileNamed:@"eating.mp3" waitForCompletion:NO];
    [SKAction playSoundFileNamed:@"glub.mp3" waitForCompletion:NO];
    [SKAction playSoundFileNamed:@"grunt.mp3" waitForCompletion:NO];
    [SKAction playSoundFileNamed:@"insect.mp3" waitForCompletion:NO];
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    

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

        
        // Move bees based on user input
        SKAction *heroMove = [SKAction moveTo:_touchLocation duration:2];
        [_hero runAction:heroMove];
        
        

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
    
    if(contact.bodyA.categoryBitMask == enemyCategory || contact.bodyB.categoryBitMask == enemyCategory)
    {
        // Play sound and remove node of player collision
        [self runAction: [SKAction playSoundFileNamed:@"eating.mp3" waitForCompletion:NO]];
        [node removeFromParent];
        
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
