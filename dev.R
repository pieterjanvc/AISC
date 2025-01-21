library(httr)
library(jsonlite)
library(keyring)

#https://huggingface.co/docs/api-inference/tasks/chat-completion?code=curl#huggingface_hub.InferenceApi

# --- HUGGINGFACE API FUNCTION --- 
hf_api <- function(userPrompt, systemPrompt, maxTokens = 200,
  
  model = "gemma-2-2b-it",
  baseURL = "https://api-inference.huggingface.co/models/"){
  
  if(missing(userPrompt) || is.na(userPrompt) || userPrompt == ""){
    stop("The userPrompt cannot be empty")
  }

  models = list(
    "gemma-2-2b-it" = c("google/gemma-2-2b-it/v1/chat/completions",
    "google/gemma-2-2b-it")
  )

  if(!model %in% names(models)){
    stop("The model needs to be one of the following: ", 
      paste(names(models), collapse = ", "))
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
    model = models[model][[1]][2],
    messages = list(
      list(role = "user", content = userPrompt),
      list(role = "system", content = ifelse(missing(systemPrompt), "", systemPrompt))
    ),
    max_tokens = maxTokens
  )
  
  result <- POST(
    url = paste0(baseURL, models[model][[1]][1]), 
    add_headers(Authorization = auth),
    content_type_json(),
    body = body |> toJSON(auto_unbox = T))
  
  return(content(result))

}

# --- TESTING API ---
answer <- hf_api(userPrompt = "poem about a bird", systemPrompt = "limerick style")
cat(answer$choices[[1]]$message$content)

