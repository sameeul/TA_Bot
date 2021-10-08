---
ℹ Please note: This repository is a Digital Worker example (Robot) adapted from an open source Robocorp Example used in an internal exercise. See "Licenses and Attributions" for more details below.
---

# 📋️ Process PDF Invoices — Digital Worker `Example`

> 🤖 `TA1-CHALLENGE`
> A digital worker that processes randomly generated PDF invoices with [Amazon Textract](https://aws.amazon.com/textract/) and saves the extracted invoice data in an Excel file.

_Table of Contents:_

- [Prerequisites](#prerequisites)
- [Setup](#setup)
- [Running](#running)
- [Using Robocorp Cloud](#using-robocorp-cloud)
- [Process Definition Overview](#process-definition-overview)
- [Licenses and Attributions](#licenses-and-attributions)
- [Resource Links](#resource-links)

## Prerequisites

1. Create an [AWS Free Tier Account](https://aws.amazon.com/free/)
2. Create a [Robocorp Cloud Account](https://id.robocorp.com/signup) (_optional_)
3. Download [Robocorp Lab](https://robocorp.com/docs/developer-tools/robocorp-lab/installation)
   > Optionally use [VSCode Plugin](https://marketplace.visualstudio.com/items?itemName=robocorp.robocorp-code)
4. See [Robocorp Developer Guides](https://robocorp.com/docs/setup/development-environment)

## Setup

1. Create an Amazon API key and key ID with access to [Amazon S3](https://docs.aws.amazon.com/AmazonS3/latest/userguide/Welcome.html) and [Amazon Textract][textract-what] in your [AWS Console](https://console.aws.amazon.com/iam/).

2. Store the AWS API key, key ID, and the AWS region in a [local Robocorp Vault][vault] either locally or in [Control Room](https://robocorp.com/docs/control-room).

   Use the following configuration:

   `/Users/username/vault.json`:

   ```json
   {
     "aws": {
       "AWS_KEY": "aws-key",
       "AWS_KEY_ID": "aws-key-id",
       "AWS_REGION": "us-east-1"
     }
   }
   ```

   `devdata/env.json`:

   ```json
   {
     "RPA_SECRET_MANAGER": "RPA.Robocorp.Vault.FileSecrets",
     "RPA_SECRET_FILE": "/Users/username/vault.json"
   }
   ```

## Running

1. Clone this repository to your local machine
   > Conventionally, store in `~/Robots/*`
2. Open Robocorp Lab, select "Open Robot"
   > 🖼 → [_see screenshot_](images/robocorp-lab-welcome.png)
3. Open `bots-ta1-challenge-telemetric`
4. In the top menu bar, select `Run` ... `▶️ Robot Test Drive`
5. You'll be prompted with a "Select Task" window
   > 🖼 → [_see screenshot_](images/robocorp-lab-tasks.png)
   1. Run the `Create Invoices` task to create the PDF invoices
   2. Run the `Process PDF invoices with Amazon Textract` task to process the PDF invoices and to generate the Excel file with the data extracted from the invoices
   3. Run the `Delete Files From Amazon S3 Bucket` to delete the PDF invoices from the Amazon S3 bucket (the `Process PDF invoices with Amazon Textract` task does this automatically in the teardown phase)

## Using Robocorp Cloud

> ☁ Using Cloud is **optional**

1. [Setup Vault][vault] in Control Room
   > 🖼 → [_see screenshot_][img/vault]
2. Add the `Create Invoices` and `Process PDF invoices with Amazon Textract` as process steps
   > 🖼 → [_see screenshot_][img/steps]
3. See [Control Room Documentation](https://robocorp.com/docs/control-room) for further instructions.
   <br>

---

<br>

## Process Definition Overview

This is in lieu of a proper [PDD](https://robocorp.com/docs/courses/implementing-rpa-robots/process-definition-document) (Process Definition Document)

### `Task 01` — Create Invoices

- Generates random PDF invoices (using [`invoiceGenerator.py`](resources/invoiceGenerator.py)) and uploads them to [Amazon S3](https://aws.amazon.com/s3/) bucket.
- Saves the generated PDF invoices to the output directory for debugging purposes.

> 🖼 → [_see example pdf invoice_][img/example_pdf_invoice]

### `Task 02` — Process PDF invoices with [Amazon Textract][textract-what]

- Reads the invoices from the Amazon S3 bucket.
- Processes the invoices with Amazon Textract.
- Saves the extracted invoice data in an Excel file in the output directory.
- Finally, deletes the PDF invoices from the Amazon S3 bucket.

> 🌐 → [_what is amazon textract?_][textract-what]

### `Task 03` — Delete Files From Amazon S3 Bucket

- A utility task for deleting the PDF invoices from the Amazon S3 bucket.
- Can be executed separately when you want to empty the Amazon S3 bucket.
- Called by the `Process PDF invoices with Amazon Textract` task in the teardown phase.

> 🖼 → [_see example excel_][img/example_excel]

<br>

💡 **What are tasks?** See [Robot Framework > Tasks](https://robocorp.com/docs/languages-and-frameworks/robot-framework/tasks) in Robocorp Docs.

---

<br>

## Licenses and Attributions

> This source code and documentation is adapted from the ["`Process Invoices with Amazon Textract`"][og:bot] example provided by Robocorp.

📰 See license at [LICENSE](LICENSE)

<br>

## Resource Links

- [RPA certification level I: Beginner's course](https://robocorp.com/docs/courses/beginners-course)
- [Handling PDF files](https://robocorp.com/docs/development-guide/pdf)
- [How to read PDF files with RPA Framework](https://robocorp.com/docs/development-guide/pdf/how-to-read-pdf-files)
- [What is Amazon Textract?][textract-what]
- [Robocorp CLI Tool: RCC](https://github.com/robocorp/rcc)
- [RPA.Cloud.AWS library](https://robocorp.com/docs/libraries/rpa-framework/rpa-cloud-aws)

<!-- Markdown Resource Reference Index -->

[og:bot]: https://robocorp.com/portal/robot/robocorp/example-process-invoices-with-amazon-textract
[excel]: https://docs.aws.amazon.com
[vault]: https://robocorp.com/docs/development-guide/variables-and-secrets/vault
[textract-what]: https://docs.aws.amazon.com/textract/latest/dg/what-is.html
[img/example_pdf_invoice]: images/example-pdf-invoice.png
[img/example_excel]: images/example-excel.png
[img/vault]: images/control-room-vault.png
[img/steps]: images/control-room-process-steps.png
