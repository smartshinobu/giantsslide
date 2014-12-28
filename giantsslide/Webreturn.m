//
//  Webreturn.m
//  nominikoi
//
//  Created by ビザンコムマック０７ on 2014/10/10.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "Webreturn.h"

@implementation Webreturn


//JSONのデータをarray型で返すメソッド
+(NSArray*)JSONArrayData:(NSString*)url{
    //NSErrorの初期化
    NSError *err = nil;
    //url先にあるデータをNSDataとして格納
    NSData *data = [self webdata:url];
    //dataを元にJSONオブジェクトを生成
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
    //値を返す
    return array;
}

//url先にあるデータを返すメソッド
+(NSData*)webdata:(NSString*)url{
    //URLを生成
    NSURL *dataurl = [NSURL URLWithString:url];
    //リクエスト生成
    NSURLRequest *request = [NSURLRequest requestWithURL:dataurl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    //レスポンスを生成
    NSHTTPURLResponse *response;
    //NSErrorの初期化
    NSError *err = nil;
    //requestによって返ってきたデータを生成
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    return data;
}

//JSONのデータをNSDictionary型で返すメソッド
+(NSDictionary*)JSONDictinaryData:(NSString*)url{
    //NSErrorの初期化
    NSError *err = nil;
    //url先にあるデータをNSDataとして格納
    NSData *data = [self webdata:url];
    //dataを元にJSONオブジェクトを生成
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
    //値を返す
    return dic;
}

//url先にある画像のデータを返すメソッド
+(UIImage*)WebImage:(NSString *)url{
    //url先にあるデータをNSDataとして格納
    NSData *data = [self webdata:url];
    //dataを元にUIImageを生成
    UIImage *img = [UIImage imageWithData:data];
    //値を返す
    return img;
}
@end
