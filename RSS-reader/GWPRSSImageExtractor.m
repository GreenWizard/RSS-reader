//
//  GWPRSSImageExtractor.m
//  RSS-reader
//
//  Created by Student on 12/01/2017.
//  Copyright © 2017 User. All rights reserved.
//

#import "GWPRSSImageExtractor.h"
@interface GWPRSSImageExtractor()<NSXMLParserDelegate>

@property (strong, readwrite) NSURL *rssURL;
@property (strong, readwrite) NSURL *imageURL;
@property (strong, readwrite) NSMutableString *string;
@property (strong, nonatomic, readwrite) NSXMLParser *xmlParser;
@property BOOL imageHasFound;

@end

@implementation GWPRSSImageExtractor

+(GWPRSSImageExtractor *)initWithURL:(NSURL *)url
{
    GWPRSSImageExtractor *result = [[GWPRSSImageExtractor alloc] init];
    result.rssURL = url;
    return result;
}

-(UIImage *)image
{
    @try
    {
        self.imageHasFound = NO;
        self.xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:self.rssURL];
        [self.xmlParser setDelegate:self];
        [self.xmlParser parse];
        if(self.imageURL)
        {
            NSData *data = [[NSData alloc] initWithContentsOfURL:self.imageURL];
            return [[UIImage alloc] initWithData:data];
        }
    }
    @catch(NSException *exception)
    {
    }
    return [UIImage imageNamed:@"rss.png"];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
    if([elementName isEqualToString:@"image"])
        self.imageHasFound = YES;
    self.string = [[NSMutableString alloc]initWithCapacity:0];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [self.string appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"url"]&&self.imageHasFound)
    {
        self.imageURL = [NSURL URLWithString:self.string];
        [self.xmlParser abortParsing];
    }
    self.string = nil;
}


@end
