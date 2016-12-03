//
//  RSSParserDelgate.m
//  RSS-reader
//
//  Created by Student on 22/11/2016.
//  Copyright © 2016 User. All rights reserved.
//

#import "GWPRSSParserDelegate.h"
@interface GWPRSSParserDelegate()<NSXMLParserDelegate>

@property (nonatomic, strong) NSMutableDictionary *dictData;
@property (nonatomic,strong) NSMutableArray *marrXMLData;
@property (nonatomic,strong) NSMutableString *mstrXMLString;
@property (nonatomic,strong) NSMutableDictionary *mdictXMLPart;


@end

@implementation GWPRSSParserDelegate

@synthesize marrXMLData;
@synthesize mstrXMLString;
@synthesize mdictXMLPart;

- (NSArray *)parse
{
    @try
    {
        NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:self.urlToParse];
        [xmlParser setDelegate:self];
        [xmlParser parse];
        return marrXMLData;
    }
        
    @finally{}
        return nil;
    
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
        || [elementName isEqualToString:@"link"]
        || [elementName isEqualToString:@"guid"])
    {
        [mdictXMLPart setObject:mstrXMLString forKey:elementName];
    }
    if ([elementName isEqualToString:@"item"])
    {
        GWPShortNews *news = [GWPShortNews createNews:[NSNumber numberWithInt:0]
                                                title:[mdictXMLPart objectForKey:@"title"]
                                      publicationDate:[mdictXMLPart objectForKey:@"pubDate"]
                                              details:[mdictXMLPart objectForKey:@"description"]
                                                 link:[NSURL URLWithString:[mdictXMLPart objectForKey:@"link"]]
                                                 giud:[NSURL URLWithString:[mdictXMLPart objectForKey:@"guid"]]];
        [marrXMLData addObject:news];
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
