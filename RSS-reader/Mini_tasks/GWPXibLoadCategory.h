//
//  GWPXibLoadCategory.h
//  RSS-reader
//
//  Created by Student on 25/11/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject(GWPXibLoader)

-(id)load:(Class)ObjectClass
  fromXib:(NSString *)name;

@end
