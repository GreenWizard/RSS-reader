

#import<Foundation/Foundation.h>

@class GWPRSS;

@protocol GWPNewsReciever_RSSTable <NSObject>

@property (readwrite, atomic, strong) GWPRSS *currentRSS;
@property (readonly, atomic, strong) NSArray *rssList;

+(id)getReciever;

-(void)loadBaseData;
-(void)addNewRSS:(GWPRSS *)rss;
-(void)editRSS:(GWPRSS *)rss
        newRSS:(GWPRSS *)newRSS;
-(void)deleteRSS:(GWPRSS *)rss;


@end


