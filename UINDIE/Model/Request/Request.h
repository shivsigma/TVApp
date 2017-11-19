//
//  Request.h
//  Vinly
//
//  Created by HARDIK TALAVIYA on 2/2/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestDelegate.h"
#import "URLSchema.h"
#import "JSON.h"
#import "Account.h"
#import "NSMutableArray+Join.h"

typedef enum {
    GET = 1,
    POST = 2,
    PUT = 3,
    DELETE = 4,
}RequestMethod;

@interface Request : NSObject
<NSURLConnectionDelegate>{
    
    id<RequestDelegate> _delegate;
    
    NSURLConnection *_connections;
    
    NSMutableURLRequest *_request;
    
    NSMutableDictionary *_postParameters;
    
    NSMutableData *_data;
    
    id _responseData;
    
    RequestMethod _methodType;
    
    BOOL _IsSuccess;
    
    NSString *_message;
    
    NSString *_Tag;
    
    int _StatusCode;
    
    NSString *_postData;
    
    NSString *_urlString;
    
    BOOL status;
    
    int _errorCode;
    
    UIImage * _image;
    
}

@property (nonatomic ,retain) UIImage * image;

@property (nonatomic, readwrite, retain) id<RequestDelegate> delegate;

@property (nonatomic, readwrite, retain) NSString *urlString;

@property (nonatomic, readwrite, retain) NSString *message;

@property (nonatomic, readonly) RequestMethod methodType;

@property (nonatomic, assign) BOOL IsSuccess;

@property (nonatomic, readonly) id responseData;

@property (nonatomic, readwrite, retain) NSString *Tag;

@property (nonatomic, assign) int StatusCode;

@property (nonatomic, retain, readwrite) NSString *postData;

@property (nonatomic, assign) int errorCode;

- (id) initWithUrlPart:(NSString*) urlPart andDelegate:(id<RequestDelegate>) del andMethod:(RequestMethod) method;

- (void)setParameter:(id)parameter forKey:(NSString *)key;

- (void) startRequest;

@end
