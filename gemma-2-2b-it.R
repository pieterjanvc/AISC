library(httr)
library(jsonlite)
library(keyring)

#https://huggingface.co/docs/api-inference/tasks/chat-completion?code=curl#huggingface_hub.InferenceApi

# --- HUGGINGFACE API FUNCTION --- 
fh_llm <- function(userPrompt, systemPrompt, maxTokens = 200) {
  
  if(missing(userPrompt) || is.na(userPrompt) || userPrompt == ""){
    stop("The userPrompt cannot be empty")
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
    url = "https://api-inference.huggingface.co/models/google/gemma-2-2b-it/v1/chat/completions",
    add_headers(Authorization = auth),
    content_type_json(),
    body = body |> toJSON(auto_unbox = T))
  
  return(content(result))

}

# --- EXAMPLE USE ---
answer <- fh_llm(
  userPrompt = "poem about a funny bird", 
  systemPrompt = "limerick style"
)
cat(answer$choices[[1]]$message$content)
