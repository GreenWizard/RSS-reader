
#import<Foundation/Foundation.h>


@protocol GWPNewsRecieverDelegate <NSObject>

-(void)updateStarded;
-(void)inputClosed;
-(void)updateCompletedWithResult;
-(void)updateCompletedWithError;

@end


