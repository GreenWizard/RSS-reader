
#import<Foundation/Foundation.h>

@class GWPShortNews;

@protocol GWPNewsReciever_NewsBody <NSNumber>

-(void)markNewsAsReadedByID:(GWPShortNews *)news;

@end
