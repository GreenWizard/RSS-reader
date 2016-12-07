//
//  RSSParserDelgate.m
//  RSS-reader
//
//  Created by Student on 22/11/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import "GWPRSSParser.h"
@interface GWPRSSParser()<NSXMLParserDelegate>

@property (nonatomic,strong) NSMutableArray *newsArray;
@property (nonatomic,strong) NSMutableString *itemString;
@property (nonatomic,strong) NSMutableDictionary *newsDictionary;


@end

@implementation GWPRSSParser

@synthesize newsArray;
@synthesize itemString;
@synthesize newsDictionary;

- (NSArray *)parse
{
        NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:self.urlToParse];
        [xmlParser setDelegate:self];
        [xmlParser parse];
        return newsArray;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
    if ([elementName isEqualToString:@"rss"]) {
        newsArray = [[NSMutableArray alloc] init];
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
        GWPShortNews *news = [self createNews];
        [newsArray addObject:news];
    }
    itemString = nil;
}

-(void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock
{
    itemString = [[NSMutableString alloc] initWithData:CDATABlock
                                              encoding:NSUTF8StringEncoding];
}

-(GWPShortNews *)createNews
{
    return [GWPShortNews createNews:[newsDictionary objectForKey:@"title"]
                    publicationDate:[newsDictionary objectForKey:@"pubDate"]
                            details:[newsDictionary objectForKey:@"description"]
                               link:[NSURL URLWithString:[newsDictionary objectForKey:@"link"]]
                               giud:[NSURL URLWithString:[newsDictionary objectForKey:@"guid"]]];
}

-(void)tryToAddElementToDictionary:(NSString *)elementName
{
    if ([elementName isEqualToString:@"title"]
        || [elementName isEqualToString:@"pubDate"]
        || [elementName isEqualToString:@"description"]
        || [elementName isEqualToString:@"link"]
        || [elementName isEqualToString:@"guid"])
    {
        [newsDictionary setObject:itemString forKey:elementName];
    }
}

@end
