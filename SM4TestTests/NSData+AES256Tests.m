#import <XCTest/XCTest.h>
#import "NSData+AES256.h"

@interface NSData_AES256Tests : XCTestCase
@end

@implementation NSData_AES256Tests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testEncryption {
    NSString *key = @"c47b0294dbbbee0fec4757f22ffeee3587ca4730c3d33b691df38bab076bc558";
    NSData *testData = [@"test_data_to_test_with" dataUsingEncoding:NSUTF8StringEncoding
                                               allowLossyConversion:NO];
    NSData *encryptedData = [testData AES256EncryptWithKey:key];
    NSData *decryptedData = [encryptedData AES256DecryptWithKey:key];
    NSString *content =[NSString stringWithCString:[decryptedData bytes] encoding:NSUTF8StringEncoding];
    XCTAssertEqualObjects(content, @"test_data_to_test_with");
}
    


//- (void)testEncryptionIterations
//{
//#if TARGET_OS_SIMULATOR
//    NSString *key = @"c47b0294dbbbee0fec4757f22ffeee3587ca4730c3d33b691df38bab076bc558";
//    NSData *testData = [@"test_data_to_test_with" dataUsingEncoding:NSUTF8StringEncoding
//                                               allowLossyConversion:NO];
//    NSData *encrypted = testData.copy;
//    int i;
//        
//    for (i = 0; i != 1000000; ++i)
//    {
//        encrypted = [encrypted AES256EncryptWithKey:key];
//    }
//    NSData *decrypted = encrypted.copy;
//    encrypted = nil;
//    for (i = 0; i != 1000000; ++i)
//    {
//        decrypted = [decrypted AES256DecryptWithKey:key];
//    }
//    NSString *content =[NSString stringWithCString:[decrypted bytes] encoding:NSUTF8StringEncoding];
//    XCTAssertEqualObjects(content, @"test_data_to_test_with");
//    
//#endif
//}


- (void)testPerformance
{
    [self measureMetrics:[self class].defaultPerformanceMetrics automaticallyStartMeasuring:NO forBlock:^{
        
        NSString *key = @"c47b0294dbbbee0fec4757f22ffeee3587ca4730c3d33b691df38bab076bc558";
        NSData *inputData = [NSKeyedArchiver archivedDataWithRootObject:[NSUUID UUID].UUIDString];

        [self startMeasuring];
        
        NSData *encryptedData = [inputData AES256EncryptWithKey:key];
        NSData *decryptedData = [encryptedData AES256DecryptWithKey:key];
        
        [self stopMeasuring];
        
        encryptedData = nil;
        decryptedData  = nil;
        inputData = nil;
        
    }];
}

- (void)testPerformanceIterated {
    [self measureMetrics:[self class].defaultPerformanceMetrics automaticallyStartMeasuring:NO forBlock:^{
        
        NSString *key = @"c47b0294dbbbee0fec4757f22ffeee3587ca4730c3d33b691df38bab076bc558";
        NSData *inputData = [NSKeyedArchiver archivedDataWithRootObject:[NSUUID UUID].UUIDString];
        NSData *decryptedData;
        [self startMeasuring];
        for (int i = 0; i != 10000; ++i)
        {

        NSData *encryptedData = [inputData AES256EncryptWithKey:key];
        decryptedData = [encryptedData AES256DecryptWithKey:key];
        
            encryptedData = nil;
            decryptedData  = nil;
        }
        [self stopMeasuring];

    }];
}
@end
