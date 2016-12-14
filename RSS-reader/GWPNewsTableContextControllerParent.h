
#import<Foundation/Foundation.h>
#import"GWPContextControllerParent.h"

@class GWPRSS;

@protocol GWPNewsTableContextControllerParent <GWPContextControllerParent>

-(void)contextController:(nonnull GWPContextController *)controller
      forceUpdateThisRSS:(nonnull GWPRSS *)rss;

@end

