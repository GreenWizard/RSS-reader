//
//  RSSParserDelgate.m
//  RSS-reader
//
//  Created by Student on 22/11/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import "GWPRSSParserDelegate.h"

@implementation GWPRSSParserDelegate

@synthesize marrXMLData;
@synthesize mstrXMLString;
@synthesize mdictXMLPart;

- (void)parse
{
    static BOOL flag;
    
    NSURL *url;
    
    if(flag)
    {
        url = [NSURL URLWithString:@"https://russian.rt.com/rss"];
        flag = NO;
    }
    else
    {
        url = [NSURL URLWithString:@"https://www.vesti.ru/vesti.rss"];
        flag = YES;
    }
    
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
    mstrXMLString = [[NSMutableString alloc]initWithCapacity:0];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [mstrXMLString appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"title"]
        || [elementName isEqualToString:@"pubDate"]
        || [elementName isEqualToString:@"description"]
        || [elementName isEqualToString:@"link"])
    {
        [mdictXMLPart setObject:mstrXMLString forKey:elementName];
    }
    if ([elementName isEqualToString:@"item"])
    {
        [marrXMLData addObject:mdictXMLPart];
    }
    mstrXMLString = nil;
}

-(void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock
{
    NSString *someString = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
    int i = 0;
    while(i<[someString length])
        if([someString characterAtIndex:i]!='<') ++i;
        else break;
    if(i == [someString length])
        mstrXMLString = [someString mutableCopy];
    else
        mstrXMLString = [[someString substringWithRange:NSMakeRange(0, i)] mutableCopy];
}

@end
