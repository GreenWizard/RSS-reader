#import<Foundation/Foundation.h>

@class GWPRSSListCell;

@protocol GWPRSSCell_ButtonAction <NSObject>

-(void)rssCell:(GWPRSSListCell *)cell editButtonClicked:(UIButton *)button;

@end
