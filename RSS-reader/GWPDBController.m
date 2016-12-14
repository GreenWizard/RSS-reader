//
//  GWPDBLoader.m
//  RSS-reader
//
//  Created by Student on 06/12/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import "GWPDBController.h"
#import <CoreData/CoreData.h>
#import "GWPNewsTableCC.h"
#import "GWPRSSTableCC.h"
#import "GWPRSSEditViewCC.h"
#import "GWPNewsBodyCC.h"
#import "GWPRecieverCC.h"
#import "GWPRSSData+CoreDataClass.h"
#import "GWPNewsTableContextControllerParent.h"
#import "GWPRecieverControllerParent.h"
#import "GWPRSS.h"
#import "GWPRSSData+CoreDataClass.h"

@interface GWPDBController()<GWPNewsTableContextControllerParent, GWPRecieverControllerParent>

@property (strong) NSManagedObjectContext *parentContext;
@property (strong) NSMutableArray *recieverContextStorage;

@property (strong) NSManagedObjectModel *managedModel;
@property (strong) NSPersistentStoreCoordinator *storeCoordinator;

@end


@implementation GWPDBController

+(id)getInstance
{
    static GWPDBController *_selfInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _selfInstance = [[GWPDBController alloc] init];
    });
    return _selfInstance;
}

-(id)init
{
    id _self = [super init];
    if(!_self) return nil;
    
    [_self initCoreData];
    
    return _self;
}

-(void)initCoreData
{
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"DB"
                                              withExtension:@"momd"];
    self.managedModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSAssert(self.managedModel, @"Error initializing Managed Object Model");
    
    self.storeCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedModel];
    
    self.parentContext = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    self.parentContext.persistentStoreCoordinator = self.storeCoordinator;
    
    self.recieverContextStorage = [[NSMutableArray alloc] initWithCapacity:0];
    
    NSManagedObjectContext *uiContext = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSMainQueueConcurrencyType];
    uiContext.parentContext = self.parentContext;

        
    self.newsTableCC = [[GWPNewsTableCC alloc] initWithContext:uiContext
                                              parentController:self];

    self.rssTableCC =  [[GWPRSSTableCC alloc] initWithContext:uiContext
                                             parentController:self];

    self.rssEditViewCC = [[GWPRSSEditViewCC alloc]initWithContext:uiContext
                                                 parentController:self];
    
    self.newsBodyCC = [[GWPNewsBodyCC alloc]initWithContext:uiContext
                                           parentController:self];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentsURL = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *storeURL = [documentsURL URLByAppendingPathComponent:@"DB.sqlite"];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        NSError *error = nil;
        NSPersistentStore *store = [self.storeCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                                       configuration:nil
                                                                                 URL:storeURL
                                                                             options:nil
                                                                               error:&error];
        NSAssert(store != nil, @"Error initializing PSC: %@\n%@", [error localizedDescription], [error userInfo]);
    });
    
    [self startPeriodicUpdate];
}

-(void)startPeriodicUpdate
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                   ^{
                       while(YES)
                       {
                           [self updateAllRSS];
                           [NSThread sleepForTimeInterval:20];
                       }
                   });
}

-(void)contextController:(GWPContextController *)controller
       saveParentContext:(nonnull NSManagedObjectContext *)context
{
    [self.newsTableCC parentControllerHasUpdated];
    [self.rssTableCC parentControllerHasUpdated];

    if([self.parentContext hasChanges])
        [self.parentContext performBlockAndWait:
         ^{
             NSError *error = nil;
             [self.parentContext save:&error];
        }];
}

-(void)contextController:(GWPContextController *)controller forceUpdateThisRSS:(GWPRSS *)rss
{
    [self createContextControllerForRSS:rss];
}

-(void)createContextControllerForRSS:(GWPRSS *)rss
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                   ^{
                       NSManagedObjectContext *context = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSPrivateQueueConcurrencyType];
                       context.parentContext = self.parentContext;
                       
                       GWPRecieverCC *newCC = [[GWPRecieverCC alloc]initWithContext:context
                                                                   parentController:self];
                       newCC.rss = rss;
                       [self.recieverContextStorage addObject:newCC];
                       [newCC updateRSS];
                   });
}

-(void)updateAllRSS
{

    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"RSS"];
        
    NSError *error = nil;
    NSArray *results = [self.parentContext executeFetchRequest:request error:&error];
    if (!results)
        NSLog(@"Error fetching News objects: %@\n%@", [error localizedDescription], [error userInfo]);
    
    for( GWPRSSData *data in results)
        [self createContextControllerForRSS:[self fromDataToRSS:data]];
}

-(void)contextControllerUpdateComplete:(GWPContextController *)controller
{
    [self contextController:controller
                        saveParentContext:self.parentContext];
    [self.recieverContextStorage removeObject:controller];
    NSLog(@"remaining recievers %lu", [self.recieverContextStorage count]);
    if(![self.recieverContextStorage count])
        NSLog(@"---------------------------");
}

-(GWPRSS *)fromDataToRSS:(GWPRSSData *)data
{
    GWPRSS *result = [GWPRSS createRSS:data.title
                                  link:[NSURL URLWithString:data.link]
                            unreadNews:0];
    return result;
}
@end
