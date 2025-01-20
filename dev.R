library(httr)
library(jsonlite)

#https://huggingface.co/docs/api-inference/tasks/chat-completion?code=curl#huggingface_hub.InferenceApi

# --- HUGGINGFACE API FUNCTION --- 
hf_api <- function(userPrompt, systemPrompt, APIkey, maxTokens = 200,
  
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

  if(missing(APIkey)){
    APIkey = Sys.getenv("huggingface_API")
    if(APIkey == ""){
      stop("Please set a system environment variable called 'huggingface_API' ", 
      "with the token generated on Huggingface. Alternatively, provide the ",
      "token directly to the 'APIkey' argument (don't hardcode for safety reasons)"
    )
    }
  }

  auth <- sprintf("Bearer %s", APIkey)
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

