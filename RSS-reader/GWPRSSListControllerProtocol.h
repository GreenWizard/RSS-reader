

#import<Foundation/Foundation.h>
#import "GWPDBControllerDelegate.h"

@class GWPRSS;

@protocol GWPRSSListControllerProtocol <NSObject>

@property (readonly, atomic, strong) NSArray *rssList;
@property (readwrite, atomic, weak) id<GWPDBControllerDelegate> delegate;
-(void)updateRSSList;

@end


