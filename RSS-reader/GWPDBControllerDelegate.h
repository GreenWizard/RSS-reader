
#import<Foundation/Foundation.h>


@protocol GWPDBControllerDelegate <NSObject>

-(void)dbControllerUpdateStarded:(id)controller;
-(void)dbControllerUpdateCompleted:(id)controller;
-(void)dbControllerUpdateFailed:(id)controller;

@end


