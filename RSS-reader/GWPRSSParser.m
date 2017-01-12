//
//  RSSParserDelgate.m
//  RSS-reader
//
//  Created by Student on 22/11/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import "GWPRSSParser.h"
@interface GWPRSSParser()<NSXMLParserDelegate>

@property (nonatomic,strong) NSMutableDictionary *newsStorage;
@property (nonatomic,strong) NSMutableString *itemString;
@property (nonatomic,strong) NSMutableDictionary *newsDictionary;


@end

@implementation GWPRSSParser

@synthesize newsStorage;
@synthesize itemString;
@synthesize newsDictionary;

- (NSMutableDictionary *)parse
{
    @try
    {
        NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:self.urlToParse];
        [xmlParser setDelegate:self];
        [xmlParser parse];
        return newsStorage;
    }
    @catch(NSException *exception)
    {
        return nil;
    }
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
    if ([elementName isEqualToString:@"rss"]) {
        newsStorage = [[NSMutableDictionary alloc] init];
    }
    if ([elementName isEqualToString:@"item"]) {
        newsDictionary = [[NSMutableDictionary alloc] init];
    }
    itemString = [[NSMutableString alloc]initWithCapacity:0];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [itemString appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    [self tryToAddElementToDictionary:elementName];
    
    if ([elementName isEqualToString:@"item"])
    {
        GWPNews *news = [self createNews];
        [newsStorage setObject:news
                        forKey:news.link];
    }
    itemString = nil;
}

-(void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock
{
    itemString = [[NSMutableString alloc] initWithData:CDATABlock
                                              encoding:NSUTF8StringEncoding];
}

-(GWPNews *)createNews
{
    return [GWPNews createNews:[newsDictionary objectForKey:@"title"]
                    publicationDate:[newsDictionary objectForKey:@"pubDate"]
                            details:[newsDictionary objectForKey:@"description"]
                          link:[NSURL URLWithString:[newsDictionary objectForKey:@"link"]]];
}

-(void)tryToAddElementToDictionary:(NSString *)elementName
{
    if ([elementName isEqualToString:@"title"]
        || [elementName isEqualToString:@"pubDate"]
        || [elementName isEqualToString:@"description"]
        || [elementName isEqualToString:@"link"])
    {
        [newsDictionary setObject:itemString forKey:elementName];
    }
}

@end
