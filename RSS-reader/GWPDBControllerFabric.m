//
//  GWPDBControllerFabric.m
//  RSS-reader
//
//  Created by Student on 08/12/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import "GWPDBControllerFabric.h"
#import "GWPDBController.h"

@implementation GWPDBControllerFabric

+(id)getDBControllerForNewsTable
{
    GWPDBController *controller = [GWPDBController getInstance];
    return controller.newsTableCC;
}

+(id)getDBControllerForNewsBodyView
{
    GWPDBController *controller = [GWPDBController getInstance];
    return controller.newsBodyCC;
}

+(id)getDBControllerForRSSTable
{
    GWPDBController *controller = [GWPDBController getInstance];
    return controller.rssTableCC;
}

+(id)getDBControllerForRSSEditView
{
    GWPDBController *controller = [GWPDBController getInstance];
    return controller.rssEditViewCC;
}

+(id)alloc
{
    return nil;
}

@end
