# AISC - Course Projects

## About

This repo contains boilerplate code and examples on how to use AI models
provided via Huggingface.

## API Key / Token

You will need to generate a Huggingface API Token in order to access the models.

1. Login to your Huggingface account
2. Click on your Profile badge (top right) --> Access Tokens
3. Create a new token, and select the following permissions
   - Make calls to the serverless Inference API
   - Make calls to Inference Endpoints
4. Once you have generated the token, save it in a secure location (see below
   how to save as a system variable)

### Save token as a system variable

If you have the token as a system variable, you'll be able to access it safely
in R without the need to keep copy-pasting it.

#### Windows

1. Open the Start menu, then start typing "environment variable"
2. THe option "Edit the system environment variables" will show up. Click it
3. Click the "Environment Variables" button neat the bottom of the new window
4. Under user variables, click new
5. Name the variable `huggingface_API` and set the value to the Huggingface
   token

#### MacOS

*todo*
