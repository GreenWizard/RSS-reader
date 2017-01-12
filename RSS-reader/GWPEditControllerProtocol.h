
#import<Foundation/Foundation.h>

@class GWPRSS;

@protocol GWPEditControllerProtocol <NSObject>

-(void)addNewRSS:(GWPRSS *)rss;
-(void)editRSS:(GWPRSS *)rss
        newRSS:(GWPRSS *)newRSS;
-(void)deleteRSS:(GWPRSS *)rss;

@end
