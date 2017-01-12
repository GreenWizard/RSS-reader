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

+(id)newsListController
{
    GWPDBController *controller = [GWPDBController getInstance];
    return controller.newsTableCC;
}

+(id)newsMarkerController
{
    GWPDBController *controller = [GWPDBController getInstance];
    return controller.newsBodyCC;
}

+(id)rssListController
{
    GWPDBController *controller = [GWPDBController getInstance];
    return controller.rssTableCC;
}

+(id)editController
{
    GWPDBController *controller = [GWPDBController getInstance];
    return controller.rssEditViewCC;
}

+(id)alloc
{
    return nil;
}

@end
