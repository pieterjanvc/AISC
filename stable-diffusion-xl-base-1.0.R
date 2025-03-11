library(httr)
library(jsonlite)
library(keyring)

hf_image <- function(prompt, fileName, width = 512, height = 512, 
  num_inference_steps = 50){
  
  if(missing(prompt) || is.na(prompt) || userPrompt == ""){
    stop("The prompt cannot be empty")
  }

  if(missing(fileName) || is.na(fileName) || fileName == ""){
    stop("The fileName cannot be empty")
  }

  if(!"huggingface_API" %in% key_list()$service){
    stop(
      "The 'huggingface_API' token was not found. Please set it using the ", 
      "following command `keyring::key_set(\"huggingface_API\")` ",
      " No username required, and put the token as the password"
    )
  }

  auth <- sprintf("Bearer %s", key_get("huggingface_API"))
  body <- list(
    inputs = prompt, 
    options = list(
      width = width,
      height = height, 
      num_inference_steps = num_inference_steps
  ))
  
  result <- POST(
    url = "https://api-inference.huggingface.co/models/stabilityai/stable-diffusion-xl-base-1.0", 
    add_headers(Authorization = auth),
    content_type_json(),
    body = body |> toJSON(auto_unbox = T)
  )

  writeBin(content(result, "raw"),fileName)
  
  return(TRUE)

}

# --- EXAMPLE USE ---
hf_image <- hf_image(
  prompt = "bird in a cage, picasso style", 
  fileName = "picassoBird.jpg"
)
