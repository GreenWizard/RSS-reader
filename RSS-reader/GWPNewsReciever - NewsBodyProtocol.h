//
//  GWPNewsReciever - NewsBodyProtocol.h
//  RSS-reader
//
//  Created by Student on 30/11/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import<Foundation/Foundation.h>
#import "GWPShortNews.h"



@protocol GWPNewsReciever_NewsBody <NSObject>

@property (readonly, atomic, strong) GWPShortNews *currentNews;
+(id)getReciever;

@end

