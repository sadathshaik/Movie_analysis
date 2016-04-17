library(RSelenium)
library(rvest)
checkForServer()
startServer()
Sys.sleep(5) # give the binary a moment
remDr <- remoteDriver()
remDr$open()
remDr$navigate("https://www.youtube.com/watch?v=q1kYpWU7apI")
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
text <- read_html(page_source[[1]]) %>% html_nodes(".comment-renderer-text-content") %>% html_text()


#combine the data in a data.frame
dat <- data.frame(text = text)
dat

remDr$close()