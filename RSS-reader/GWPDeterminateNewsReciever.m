//
//  DeterminateNewsReciever.m
//  RSS-reader
//
//  Created by User on 17/11/16.
//  Copyright © 2016 User. All rights reserved.
//

#import "GWPDeterminateNewsReciever.h"

@interface GWPDeterminateNewsReciever()

@end

@implementation GWPDeterminateNewsReciever

+(id)getReciever{
    return [[GWPDeterminateNewsReciever alloc]init];
}

-(void)update{
    return;
}

-(NSMutableArray *)newsList{
        NSMutableArray *result = [[NSMutableArray alloc]init];
    
        for(int i = 0; i<self.numberOfNews.intValue; ++i )
        {
            GWPShortNews *news = [[GWPShortNews alloc]init];
            news.Id = [NSNumber numberWithInt:i];
            news.title = [NSString stringWithFormat:@"%i news", i+1];
            news.details = [NSString stringWithFormat:@"%i news details",i+1];
            news.publicationDate = [NSString stringWithFormat:@"%i.%i.%i",i%31+1,i%12+1,2000+i];
            [result addObject:news];
        }
        return result;

}

-(GWPShortNews *)newsById:(NSNumber *)newsId{
    GWPShortNews *news = [[GWPShortNews alloc] init];
    news.title = [NSString stringWithFormat:@"%i news", newsId.intValue+1];
    news.details = [NSString stringWithFormat:@"%i full news details",newsId.intValue+1];
    news.publicationDate = [NSString stringWithFormat:@"%i.%i.%i",newsId.intValue%31+1,
                            newsId.intValue%12+1,2000+newsId.intValue];
    return news;
}

@end
