//
//  NewsRecieverProtocol.h
//  RSS-reader
//
//  Created by User on 17/11/16.
//  Copyright © 2016 User. All rights reserved.
//


#import "GWPNewsReciever - NewsTableProtocol.h"
#import "GWPNewsReciever - NewsBodyProtocol.h"
#import "GWPNewsReciever - RSSTableProtocol.h"



@protocol GWPNewsRecieverProtocol <NSObject,
                                    GWPNewsReciever_NewsBody,
                                    GWPNewsReciever_NewsTable,
                                    GWPNewsReciever_RSSTable>
@end


