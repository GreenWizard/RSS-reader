
#import<Foundation/Foundation.h>
#import "GWPDBControllerDelegate.h"

@class GWPRSS;

@protocol GWPDBContollerForNewsTable <NSObject>

@property (readonly, atomic, strong) NSArray *newsList;
@property (readwrite, atomic, weak) id<GWPDBControllerDelegate> delegate;

-(void)updateNews:(GWPRSS *)rss;

@end

