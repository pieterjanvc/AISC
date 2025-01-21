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

### Save the API token to the credential store

The provided functions will ask for your Token the first time you use it by
telling you to run the following function

```r
keyring::key_set("huggingface_API")
```

- Make sure you have the `keyring` package installed
- If you are having issues with an incorrect Token, run the function again to
  update the token
