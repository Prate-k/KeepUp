//
//  SongsViewModelObjCFunctionable.h
//  KeepUp
//
//  Created by Prateek Kambadkone on 2019/03/26.
//  Copyright © 2019 Prateek Kambadkone. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SongsViewModelObjCFunctionable

-(void) getAlbum: (NSString* ) artistName : (NSString*)albumName;

@end

NS_ASSUME_NONNULL_END
