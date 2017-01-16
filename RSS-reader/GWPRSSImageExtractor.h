//
//  GWPRSSImageExtractor.h
//  RSS-reader
//
//  Created by Student on 12/01/2017.
//  Copyright © 2017 User. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GWPRSSImageExtractor : NSObject

@property (strong, readonly) UIImage *image;

+(GWPRSSImageExtractor *)initWithURL:(NSURL *)url;

@end
