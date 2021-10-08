*** Settings ***
Documentation     Processes PDF invoices with Amazon Textract.
...               Saves the extracted invoice data in an Excel file.
Resource          invoices.resource
Resource          logger.resource

*** Variables ***


*** Tasks ***
Process PDF invoices with Amazon Textract

    [Setup]    Initialize Amazon Clients
	Set Test Documentation	Process PDF invoices with Amazon Textract and etc
	Log Task Start
    @{job_ids}=    Create List
    ${filenames}=    Get File Keys From Amazon S3 Bucket
    FOR    ${filename}    IN    @{filenames}	
        ${job_id}=    Process PDF with Amazon Textract    ${filename}
        Append To List    ${job_ids}    ${job_id}
    END

	&{sub_task_meta_data_dict}=		Create dictionary      job_ids=@{job_ids}
	Log Sub Task Start	Process PDF		${sub_task_meta_data_dict}
    ${invoices}=    Wait For PDF Processing Results    ${job_ids}	
	Log Sub Task End	Process PDF


	&{sub_task_meta_data_dict}=		Create dictionary      invoices=@{invoices}
	Log Sub Task Start	Create Excel		${sub_task_meta_data_dict}
    Save Invoices To Excel    ${invoices}
	Log Sub Task End	Create Excel


	Log Task End

    [Teardown]    Delete Files From Amazon S3 Bucket

*** Tasks ***
Create Invoices
    [Setup]    Initialize Amazon Clients
	Set Test Documentation	Create Invoices Using Invoice Generator
	Log Task Start
    Create Invoices
	Log Task End

*** Tasks ***
Delete Files From Amazon S3 Bucket
    [Setup]    Initialize Amazon Clients
	Set Test Documentation	Delete Files From Amazon S3 Bucket As Part of Clean-Up
	Log Task Start	
    Delete Files From Amazon S3 Bucket
	Log Task End
