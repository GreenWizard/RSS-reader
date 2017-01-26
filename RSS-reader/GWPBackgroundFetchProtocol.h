
@class AppDelegate;

@protocol GWPBackgroundFetchProtocol <NSObject>

@property (weak) AppDelegate<*

-(id)initWithoutPeriodicUpdates;
-(void)updateAllRSS;

@end
