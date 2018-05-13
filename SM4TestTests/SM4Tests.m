#import <XCTest/XCTest.h>
#import "sm4.h"
#import "SM4SharedTestData.h"

@interface SM4TestTests : XCTestCase

@end

@implementation SM4TestTests

#pragma mark - Setup

- (BOOL)_isEqualMemory:(void *)s1 size:(size_t )n1 comparedTo: (void *)s2 ofSize:(size_t )n2{
    if (s1 == NULL && s2 == NULL)
        return YES;
    if (n1 != n2 || s1 == NULL || s2 == NULL || memcmp(s1, s2, n1) != 0) {
        
        return NO;
    }
    return YES;
}

#pragma mark - Tests

- (void)testEncryption
{
    SM4_KEY key;
    uint8_t block[SM4_BLOCK_SIZE];
    
    SM4_set_key(k, &key);
    memcpy(block, input, SM4_BLOCK_SIZE);
    
    SM4_encrypt(block, block, &key);
    
    XCTAssert([self _isEqualMemory:block size:SM4_BLOCK_SIZE comparedTo:(void *)expected ofSize:SM4_BLOCK_SIZE]);
    
     SM4_decrypt(block, block, &key);

     XCTAssert([self _isEqualMemory:block size:SM4_BLOCK_SIZE comparedTo:(void *)input ofSize:SM4_BLOCK_SIZE]);
}

- (void)testEncryptionIterated
{

        int i;
        SM4_KEY key;
        uint8_t block[SM4_BLOCK_SIZE];
        
        SM4_set_key(k, &key);
        memcpy(block, input, SM4_BLOCK_SIZE);
        
        for (i = 0; i != 1000000; ++i)
        {
            SM4_encrypt(block, block, &key);
        }
        
        XCTAssert([self _isEqualMemory:block size:SM4_BLOCK_SIZE comparedTo:(void *)expected_iter ofSize:SM4_BLOCK_SIZE]);
        
        for (i = 0; i != 1000000; ++i)
        {
            SM4_decrypt(block, block, &key);
        }
        XCTAssert([self _isEqualMemory:block size:SM4_BLOCK_SIZE comparedTo:(void *)input ofSize:SM4_BLOCK_SIZE]);
}

- (void)testPerformance
{
    [self measureMetrics:[self class].defaultPerformanceMetrics automaticallyStartMeasuring:NO forBlock:^{
        
        SM4_KEY key;
        uint8_t block[SM4_BLOCK_SIZE];
        
        SM4_set_key(k, &key);
        memcpy(block, input, SM4_BLOCK_SIZE);
        [self startMeasuring];


        
        SM4_encrypt(block, block, &key);
        SM4_decrypt(block, block, &key);
        [self stopMeasuring];
     
    }];
}

@end

