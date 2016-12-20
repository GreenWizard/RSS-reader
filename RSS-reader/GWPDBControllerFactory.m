//
//  GWPDBControllerFabric.m
//  RSS-reader
//
//  Created by Student on 08/12/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import "GWPDBControllerFactory.h"
#import "GWPDBController.h"

@implementation GWPDBControllerFactory

+(id)newsTableDBController
{
    GWPDBController *controller = [GWPDBController getInstance];
    return controller.newsTableCC;
}

+(id)newsBodyViewDBController
{
    GWPDBController *controller = [GWPDBController getInstance];
    return controller.newsBodyCC;
}

+(id)rssTableDBController
{
    GWPDBController *controller = [GWPDBController getInstance];
    return controller.rssTableCC;
}

+(id)rssEditViewDBController
{
    GWPDBController *controller = [GWPDBController getInstance];
    return controller.rssEditViewCC;
}

+(id)alloc
{
    return nil;
}

@end
