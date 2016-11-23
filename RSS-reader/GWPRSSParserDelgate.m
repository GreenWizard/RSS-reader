//
//  RSSParserDelgate.m
//  RSS-reader
//
//  Created by Student on 22/11/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import "GWPRSSParserDelgate.h"

@implementation GWPRSSParserDelgate

@synthesize marrXMLData;
@synthesize mstrXMLString;
@synthesize mdictXMLPart;

- (void)startParsing
{
    NSURL *url = [NSURL URLWithString:@"https://news.yandex.ru/hardware.rss"];
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [xmlParser setDelegate:self];
    [xmlParser parse];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
    if ([elementName isEqualToString:@"rss"]) {
        marrXMLData = [[NSMutableArray alloc] init];
    }
    if ([elementName isEqualToString:@"item"]) {
        mdictXMLPart = [[NSMutableDictionary alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (!mstrXMLString) {
        mstrXMLString = [[NSMutableString alloc] initWithString:string];
    }
    else {
        [mstrXMLString appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"title"]
        || [elementName isEqualToString:@"pubDate"]
        || [elementName isEqualToString:@"description"]
        || [elementName isEqualToString:@"link"])
    {
        [self removeWaste:mstrXMLString];
        [mdictXMLPart setObject:mstrXMLString forKey:elementName];
    }
    if ([elementName isEqualToString:@"item"])
    {
        [marrXMLData addObject:mdictXMLPart];
    }
    mstrXMLString = nil;
}

- (void)removeWaste:(NSMutableString *)input
{
    while([input length])
    {
        if(([input characterAtIndex:0]=='\n')
          ||([input characterAtIndex:0]=='\t')
          ||([input characterAtIndex:0]==' '))
            [input deleteCharactersInRange:NSMakeRange(0, 1)];
        else return;
    }
}
@end
