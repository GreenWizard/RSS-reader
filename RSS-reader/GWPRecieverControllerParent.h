#import<Foundation/Foundation.h>
#import"GWPContextControllerParent.h"

@class GWPRSS;

@protocol GWPRecieverControllerParent <GWPContextControllerParent>

-(void)contextControllerUpdateComplete:(nonnull GWPContextController *)controller;

@end
