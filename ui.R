library(shiny)
shinyUI(navbarPage("Data Science Captone Project",theme="bootstrap.css",tabPanel("Application",
     titlePanel(HTML("<center>Next Word Prediction App</center>")),
     hr(),
     h5("Wait 10 Seconds For The App To Start"),
     textInput('inputText','Input : ',"What do you think "),
     hr(),
     h5(HTML("<b>Output : </b> (Top 3 Predictions)")),
     verbatimTextOutput("text"),
     hr()
),
tabPanel("About", tags$div(HTML("
<center><h1> Author </h1><br>
<h4> Rithesh Kumar </h4>
<h5> Github Link : <a href=https://github.com/ritheshkumar95/Capstone-Project> Codes </a> </h5>
<h5> Slide Deck Link : <a href=http://rpubs.com/ritheshkumar95/73457> Codes </a></h5></center>
<br>
<h1><center> Methodology </center></h1>
<ul>
<li>The corpus for this model consisted of 3 raw text files :
          <ul>
          <li>en_US.blogs.txt</li>
          <li>en_US.news.txt</li>
          <li>en_US.twitter.txt</li>
          </ul> </li>
<br>
<br>
<li>The dataset loaded contains one line per entry of tweet,blog,news. These may contain multiple sentences. Hence these word chunks must be split into lines where each line denotes one sentence. </li>
<br>
<br>
<li>Data Cleaning Activites : 
     <ol>
     <li> Removing Numbers </li>
     <li> Removing Puntuations </li>
     <li> Removing Foreign characters </li>
     <li> Removing extra white spaces </li>
     <li> Stemming words </li>
     <li> Converting to lower case </li>
     <li> Profanity Filtering </li>
     </ol>
<br>
<br>
<li>Finally, storing the processed data in the form of a VCorpus,Plain Text Document and a Term Document Matrix is required for text mining applications. </li>
<br>
<br>
<li> Bad Words list - [https://github.com/shutterstock/List-of-Dirty-Naughty-Obscene-and-Otherwise-Bad-Words] </li>

<li> Model Building
     <ol>
     <li> Creating N-Grams from the cleaned dataset (unigrams,bigrams,trigrams and quadgrams) </li>
     <li> Calculation NGram counts using Term Frequency function </li>
     <li> Assigning probabilities to the N-Grams using simple linear interpolation with dummy lambda values. </li>
     <li> Probability Formulae Used :
     <ul>
     <li> Maximum Likelihood Estimates
     <ul>
     <li> Trigram ML estimate <br>
     qML(wi|wi−2,wi−1)=Count(wi−2,wi−1,wi) / Count(wi−2,wi−1) </li>
     <br>
     <li>Bigram ML estimate <br>
     qML(wi|wi−1)=Count(wi−1,wi) / Count(wi−1) </li>
     <br>
     <li> Unigram ML estimate <br>
     qML=Count(wi) / Count() </li> 
     </ul> </li>
     <br>
     <li> Linear Interpolation 
     <ul>
     <li> Take our estimate q(wi|wi−2,wi−1) to be: <br>
             = λ1×qML(wi|wi−2,wi−1) +λ2×qML(wi|wi−1) + λ3× qML(wi) <br>
               where λ1+λ2+λ3=1 and λi≥0∀i. <br>
          New estimate is a weighted average of the three MLEs. </li>
          <br>
          <li>For example, assuming λ1=λ2=λ3=13
          q(laughs | the, dog) <br>
          =1/3×qML(laughs | the, dog) <br>
          +1/3×qML(laughs | dog) <br>
          +1/3×qML(laughs) 
     </li>
     </ul>
     </ul>
     </ol>
<li> Prediction </li>
     <ol>
     <li> Inputted text is preprocessed using the same data cleaning activites </li>
     <li> Last 3 words entered are matched with the 4-grams and the match with highest probability is returned. </li>
     <li> If there is no match with the 4-grams lower order N-Grams are tried for matches. </li>
</ol>
</ul>

")
))))