package com.example.demo.config;

import java.net.URI;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;

@Configuration
public class S3Config {
	
	// 주소를 endpoint라고 함
	@Value("${aws.s3.endpoint}")
	private String endpoint;
	// region
	@Value("${aws.s3.region}")
	private String region;
	// access key
	@Value("${aws.s3.access-key}")
	private String accessKey;
	// secret key
	@Value("${aws.s3.secret-key}")
	private String secretKey;
	// Value 어노테이션으로 application.properties의 변수들 사용가능

	@Bean
	public S3Client S3Client() {
		return S3Client.builder()
                .region(Region.of(region))
                .endpointOverride(URI.create(endpoint))
                .credentialsProvider(() -> AwsBasicCredentials.create(accessKey, secretKey))
                .build();

	}
	
}