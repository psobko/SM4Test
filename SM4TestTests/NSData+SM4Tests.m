#import <XCTest/XCTest.h>
#import "SM4SharedTestData.h"
#import "NSData+SM4.h"

@interface NSData_SM4Tests : XCTestCase
@end

@implementation NSData_SM4Tests

#pragma mark - Setup
#pragma mark - Tests

- (void)testEncryption
{
    NSData *keyData = [NSData dataWithBytes:k length:SM4_BLOCK_SIZE];
    NSData *inputData = [NSData dataWithBytes:input length:SM4_BLOCK_SIZE];
    NSData *expectedData = [NSData dataWithBytes:expected length:SM4_BLOCK_SIZE];

    XCTAssertTrue(keyData && inputData && expectedData, @"Test data failed to initialize");
    
    NSData *encryptedData = [inputData SM4EncryptWithKey:keyData];
    XCTAssertNotEqualObjects(encryptedData, inputData, @"Encrypted data should not match input data");
    XCTAssertEqualObjects(encryptedData, expectedData, @"Encrypted data should match expected data");
    
    NSData *decryptedData = [encryptedData SM4DecryptWithKey:keyData];
    XCTAssertEqualObjects(decryptedData, inputData, @"Decrypted data should match input data");
}

- (void)testEncryptionIterated
{
    #if TARGET_OS_SIMULATOR
        int i;
        NSData *keyData = [NSData dataWithBytes:k length:SM4_BLOCK_SIZE];
        NSData *inputData = [NSData dataWithBytes:input length:SM4_BLOCK_SIZE];
        NSData *expectedData = [NSData dataWithBytes:expected_iter length:SM4_BLOCK_SIZE];
        NSData *buffer = inputData.copy;
    
        XCTAssertTrue(keyData && inputData && expectedData, @"Test data failed to initialize");


        for (i = 0; i != 1000000; ++i)
        {
            buffer = [buffer SM4EncryptWithKey:keyData];
        }
        NSData *encryptedData = buffer;
        XCTAssertNotEqualObjects(encryptedData, inputData, @"Encrypted data should not match input data");
        XCTAssertEqualObjects(encryptedData, expectedData, @"Encrypted data should match expected data");


        for (i = 0; i != 1000000; ++i)
        {
          buffer = [buffer SM4DecryptWithKey:keyData];
        }
                NSData *decryptedData = buffer;
        XCTAssertEqualObjects(decryptedData, inputData, @"Decrypted data should match input data");
    #endif
}

- (void)testPerformance {
    [self measureMetrics:[self class].defaultPerformanceMetrics automaticallyStartMeasuring:NO forBlock:^{
        
        NSData *keyData = [NSData dataWithBytes:k length:SM4_BLOCK_SIZE];
        NSData *inputData = [NSKeyedArchiver archivedDataWithRootObject:[NSUUID UUID].UUIDString];

        [self startMeasuring];
        
        NSData *encryptedData = [inputData SM4EncryptWithKey:keyData];
        NSData *decryptedData = [encryptedData SM4DecryptWithKey:keyData];

        [self stopMeasuring];
        
        encryptedData = nil;
        decryptedData  = nil;
        inputData = nil;
    }];
}

- (void)testPerformanceIterated {
    [self measureMetrics:[self class].defaultPerformanceMetrics automaticallyStartMeasuring:NO forBlock:^{
        
        NSData *keyData = [NSData dataWithBytes:k length:SM4_BLOCK_SIZE];
        NSData *inputData = [NSKeyedArchiver archivedDataWithRootObject:[NSUUID UUID].UUIDString];
        
        [self startMeasuring];
        for (int i = 0; i != 10000; ++i)
        {
            NSData *encryptedData = [inputData SM4EncryptWithKey:keyData];
            NSData *decryptedData = [encryptedData SM4DecryptWithKey:keyData];
            encryptedData = nil;
            decryptedData  = nil;
        
        }

        [self stopMeasuring];
        
    }];
}

@end
