calcprobs <- function()
{
     names(utf)[2] <- "X1"
     length <- which(btf$X1 %in% utf$X1)
     indices <- setdiff(1:nrow(btf),length)
     excluded <- data.table(btf[indices,c("freq","X1")])
     utf <- rbind(utf,data.frame(excluded[,.(freq=sum(freq)),by=X1]))
     utf <- utf[order(utf$freq,decreasing=TRUE),] 
     
utf$X1 <- as.character(utf$X1)
btf$X1 <- as.character(btf$X1)
ttf$X1 <- as.character(ttf$X1)
qtf$X1 <- as.character(qtf$X1)
btf$X2 <- as.character(btf$X2)
ttf$X2 <- as.character(ttf$X2)
qtf$X2 <- as.character(qtf$X2)
ttf$X3 <- as.character(ttf$X3)
qtf$X3 <- as.character(qtf$X3)
qtf$X4 <- as.character(qtf$X4) 

utf$prob <- utf$freq/nrow(utf)    
utf <- utf[1:8000,]
btf <- btf[btf$X1 %in% utf$X1,]
ttf <- ttf[(ttf$X1 %in% btf$X1) & (ttf$X2 %in% btf$X2),]
qtf <- qtf[(qtf$X1 %in% ttf$X1) & (qtf$X2 %in% ttf$X2) & (qtf$X3 %in%ttf$X3),]


temp <- inner_join(btf,utf,by="X1")
btf$prob <- (0.6)*(temp$freq.x/temp$freq.y) + (0.4)*temp$prob 

temp <- inner_join(ttf,btf,by=c("X1","X2"))
temp <- inner_join(temp,utf,by="X1")
ttf$prob <- (0.4)*(temp$freq.x/temp$freq.y) + (0.3)*temp$prob.x + (0.3)*temp$prob.y

temp <- inner_join(qtf,ttf,by=c("X1","X2","X3"))
temp <- inner_join(temp,btf,by=c("X1","X2"))
temp <- inner_join(temp,utf,by="X1")
qtf$prob <- (0.3)*(temp$freq.x/temp$freq.y) + (0.2)*temp$prob.x + (0.2)*temp$prob.y + 0.1*temp$prob

utf <- utf[order(utf$prob,decreasing=TRUE),]
btf <- btf[order(btf$prob,decreasing=TRUE),]
ttf <- ttf[order(ttf$prob,decreasing=TRUE),]
qtf <- qtf[order(qtf$prob,decreasing=TRUE),]

}

predict <- function(str)
{
     #str <- stemDocument(VCorpus(VectorSource(str))[[1]])[[1]]
     str <- removePunctuation(str)
     str <- paste("<cs>",str)
     str <- stripWhitespace(str)
     str <- tolower(str)
     vec <- unlist(strsplit(str," "))
     len <- length(vec)
     print(vec)
     if (vec[len]%in%utf$X1)
     {
     if (len>=3)
     {
          index <- which(qtf$X3==vec[len] & qtf$X2==vec[len-1] & qtf$X1==vec[len-2])
        if (length(index)>0) 
             {
             return(as.character(qtf[index[1],"X4"]))
               }
     }
     if (len>=2)
     {
          index <- which(ttf$X2==vec[len] & ttf$X1==vec[len-1])
          if (length(index)>0) 
          {
               return(as.character(ttf[index[1],"X3"]))
          }
     }
     index <- which(btf$X1==vec[len])
     if (length(index)>0) 
     {
          return(as.character(btf[index[1],"X2"]))     
     }
     }
     return(utf$X1[3])
}
     