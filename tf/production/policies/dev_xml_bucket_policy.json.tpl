{
   "Version": "2008-10-17",
   "Statement": [
       {
           "Effect": "Allow",
           "Action": ["s3:ListBucket"],
           "Principal": { "AWS": "${aws_account}" },
           "Resource": ["arn:aws:s3:::dev-xml-transfer"]
       },
       {
           "Effect": "Allow",
           "Principal": { "AWS": "${aws_account}" },
           "Action": [
               "s3:PutObject",
               "s3:GetObject",
               "s3:DeleteObject"
           ],
           "Resource": ["arn:aws:s3:::dev-xml-transfer/*"]
       }
   ]
}
