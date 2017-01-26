//
//  GWPBackgroundFetchController.m
//  RSS-reader
//
//  Created by Student on 26/01/2017.
//  Copyright © 2017 User. All rights reserved.
//

#import "GWPDBController.h"
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>
#import "GWPNewsListController.h"
#import "GWPRSSListController.h"
#import "GWPRSSEditController.h"
#import "GWPNewsMarkerController.h"
#import "GWPNewsRecieverController.h"
#import "GWPRSSData+CoreDataClass.h"
#import "GWPNewsListControllerParent.h"
#import "GWPRecieverControllerParent.h"
#import "GWPRSS.h"
#import "GWPRSSData+CoreDataClass.h"
#import "GWPBackgroundFetchController.h"

@interface GWPBackgroundFetchController()<GWPRecieverControllerParent>

@property (strong) NSManagedObjectContext *parentContext;
@property (strong) NSMutableDictionary *recieverContextStorage;

@property (strong) NSManagedObjectModel *managedModel;
@property (strong) NSPersistentStoreCoordinator *storeCoordinator;

@property (readwrite) void (^backgroundFethcCompletionHandler)(UIBackgroundFetchResult);

@end

@implementation GWPBackgroundFetchController

+(GWPBackgroundFetchController *)initWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    GWPBackgroundFetchController *controller = [[GWPBackgroundFetchController alloc] init];
    
    [controller initCoreData];
    [controller setBackgroundFethcCompletionHandler:completionHandler];
    
    return controller;
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

    self.recieverContextStorage = [[NSMutableDictionary alloc] initWithCapacity:0];

    NSManagedObjectContext *uiContext = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSMainQueueConcurrencyType];
    uiContext.parentContext = self.parentContext;

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
    NSAssert(store != nil, @"Error initializing PSC: %@\n%@", [error localizedDescription], [error userInfo]);});
}


-(void)updateAllRSS
{
    self.updateFailedWhithError = NO;
    self.updateHaveResult = NO;
    
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
    @synchronized (nil) {
        NSURL *link = [(GWPNewsRecieverController *)controller rss].link;
        [self.recieverContextStorage removeObjectForKey:link];
        if(!self.recieverContextStorage.count)
        {
            if(self.updateHaveResult)
                self.backgroundFethcCompletionHandler(UIBackgroundFetchResultNewData);
            else if (self.updateFailedWhithError)
                self.backgroundFethcCompletionHandler(UIBackgroundFetchResultFailed);
            else
                self.backgroundFethcCompletionHandler(UIBackgroundFetchResultNoData);
        }
    }
}

-(GWPRSS *)fromDataToRSS:(GWPRSSData *)data
{
    GWPRSS *result = [GWPRSS createRSS:data.title
                                  link:[NSURL URLWithString:data.link]
                            unreadNews:0];
    return result;
}

-(void)createContextControllerForRSS:(GWPRSS *)rss
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                   ^{
                       NSManagedObjectContext *context = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSPrivateQueueConcurrencyType];
                       context.parentContext = self.parentContext;
                       
                       GWPNewsRecieverController *newCC = [[GWPNewsRecieverController alloc]initWithContext:context
                                                                                           parentController:self];
                       newCC.rss = rss;
                       if(![self.recieverContextStorage objectForKey:rss.link])
                       {
                           [self.recieverContextStorage setObject:newCC forKey:rss.link];
                           [newCC updateRSS];
                       }
                   });
}

-(void)contextController:(GWPContextController *)controller
       saveParentContext:(nonnull NSManagedObjectContext *)context
{
    if([self.parentContext hasChanges])
        [self.parentContext performBlockAndWait:
         ^{
             NSError *error = nil;
             [self.parentContext save:&error];
         }];
}

@end
