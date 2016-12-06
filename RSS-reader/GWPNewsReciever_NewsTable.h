
#import<Foundation/Foundation.h>
#import "GWPShortNews.h"
#import "GWPNewsRecieverDelegate.h"
#import "GWPRSS.h"


@protocol GWPNewsReciever_NewsTable <NSObject>

@property (readonly, atomic, strong) NSMutableArray *newsList;
@property (readwrite, atomic, weak) id<GWPNewsRecieverDelegate> delegate;
@property (readwrite, atomic, strong) GWPRSS *currentRSS;

+(id)getReciever;

-(void)updateNews;

@end

