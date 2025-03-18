library(httr)
library(jsonlite)
library(keyring) 


# List of models: https://huggingface.co/docs/api-inference/en/tasks/text-generation?code=curl 
# List of select models: https://github.com/pieterjanvc/AISC/blob/main/model_list.md 



hf_llm <- function(userPrompt, systemPrompt, model = "google/gemma-2-2b-it", maxTokens = 200) {
    
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
        model = model,
        messages = list(
            list(role = "user", content = userPrompt),
            list(role = "system", content = ifelse(missing(systemPrompt), "", systemPrompt))
        ),
        max_tokens = maxTokens
    )
    
    result <- POST(
        url = sprintf("https://api-inference.huggingface.co/models/%s/v1/chat/completions", model),
        add_headers(Authorization = auth),
        content_type_json(),
        body = body |> toJSON(auto_unbox = TRUE))
    
    return(content(result))
    
}


answer <- hf_llm(
    userPrompt = "What are medical diagnosis?", 
    systemPrompt = "You are a health care provider", 
    model = "google/gemma-2-2b-it"
    )

answer
