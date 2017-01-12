
#import<Foundation/Foundation.h>
#include <CoreData/CoreData.h>

@class GWPContextController;

@protocol GWPContextControllerParent <NSObject>

-(void)contextController:(nonnull GWPContextController *)controller
     saveParentContext:(nonnull NSManagedObjectContext *)context;

@end
