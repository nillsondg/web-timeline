## Future Timeline via yandex.ru

library('RCurl')
library('XML') 

searchURL <- "https://yandex.ru/yandsearch?text="

# yandex search api
# get url for request
# https://xml.yandex.ru/settings/
# don't use cause yandex search api limit available requests to 1 at a day probably
searchURL.Api <- "https://yandex.ru/search/xml?query="
search.settings <- c()

file.output <- './Timeline.csv'

# yandex search language
# https://yandex.ru/support/search/query-language/qlanguage.html
search.queries <- c("game development date:%i**",
                 "game development %i",
                 "+game +development +%i")
year.low <- 2010
year.high <- 2020
data <- data.frame()

for(year in year.low:year.high){
  print(paste("Processing year", year))
  
  for(query in search.queries){
    fileURL <- paste0(searchURL, sprintf(query, year))
    fileURL <- URLencode(fileURL)
    
    print(paste("Processing query", fileURL))
    
    # cause faulire when captcha invoked
    # http://stackoverflow.com/questions/26473611/rcurl-not-working-in-download-of-url-content
    html <- getURL(fileURL, followLocation = T)
    doc <- htmlTreeParse(html, useInternalNodes = T)
    rootNode <- xmlRoot(doc)
    
    links <- xpathSApply(rootNode, '//a[contains(@class, "link organic__url")]',
                         xmlGetAttr, 'href')

    headers <- xpathSApply(rootNode, '//a[contains(@class, "link organic__url")]',
                     xmlValue)
    
    sources <- xpathSApply(rootNode, '//div[@class="path organic__path"]',
                           xmlValue)

    data.request <- data.frame(Year = year, Header = headers, Source = sources, URL = links)
    
    #append request data to data frame
    data <- rbind(data, data.request)
    
    # maybe this break exhausting captcha service
    Sys.sleep(runif(1, 100.0, 120.0))
  }
}

write.csv(data, file = file.output, row.names = F)

print('Done')