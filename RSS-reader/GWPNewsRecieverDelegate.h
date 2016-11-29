//
//  GWPNewsRecieverDelegate.h
//  RSS-reader
//
//  Created by Student on 23/11/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import<Foundation/Foundation.h>
#ifndef GWPNewsRecieverDelegate_h
#define GWPNewsRecieverDelegate_h

@protocol GWPNewsRecieverDelegate <NSObject>

-(void)updateStarded;
-(void)inputClosed;
-(void)updateCompletedWithResult;
-(void)updateCompletedWithError;

@end

#endif /* GWPNewsRecieverDelegate_h */
