package com.paradisiac.product;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.PutObjectRequest;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.PostConstruct;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

@Service
public class AmazonS3ClientService {

    private AmazonS3 amazonS3;

    @Value("${aws.s3.bucketName}")
    private String bucketName;

    @Value("${aws.region}")
    private String region;

    @PostConstruct
    private void initializeAmazon() {
        this.amazonS3 = AmazonS3ClientBuilder.standard()
                .withRegion(region)
                .build();
    }

    public String uploadFileToS3Bucket(MultipartFile multipartFile, boolean enablePublicReadAccess) {
        String fileUrl = "";
        try {
            // Create a file to write the multipartFile content
            File file = new File(multipartFile.getOriginalFilename());
            FileOutputStream fos = new FileOutputStream(file);
            fos.write(multipartFile.getBytes());
            fos.close();

            String fileName = generateFileName(multipartFile);

            // Upload file
            PutObjectRequest putObjectRequest = new PutObjectRequest(bucketName, fileName, file);
            if (enablePublicReadAccess) {
                putObjectRequest.withCannedAcl(CannedAccessControlList.PublicRead);
            }
            amazonS3.putObject(putObjectRequest);

            // Get file URL from S3
            fileUrl = amazonS3.getUrl(bucketName, fileName).toString();

            // Delete file after uploading to S3 since we no longer need the local file
            file.delete();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return fileUrl;
    }

    private String generateFileName(MultipartFile multiPart) {
        return new StringBuilder()
                .append(System.currentTimeMillis())
                .append("-")
                .append(multiPart.getOriginalFilename().replace(" ", "_"))
                .toString();
    }
}
