library(RSelenium)
library(rvest)
library(XML)
cat("Enter a movie name please: ");
a <- readLines("stdin",n=1);
cat("You entered")
 str(a);
cat( "\n" )

url <- paste(c("https://www.youtube.com/results?search_query=",a), collapse = '')
# url <- str(url)
# url
link.url <- url
link.url


checkForServer()
startServer()
Sys.sleep(5) # give the binary a moment
remDr <- remoteDriver()
remDr$open()
remDr$navigate(link.url)
remDr$getTitle()[[1]] # [1] "YouTube"

# scroll down
for(i in 1:5){      
  remDr$executeScript(paste("scroll(0,",i*10000,");"))
  Sys.sleep(5)    
}

# Get page source and parse it via rvest
page_source <- remDr$getPageSource()

# page_source
# author <- read_html(page_source[[1]]) %>% html_nodes(".user-name") %>% html_text()
# author
text <- read_html(page_source[[1]]) %>% html_nodes(css =".yt-lockup-title a") %>% html_attr("href")

text

remDr$close()