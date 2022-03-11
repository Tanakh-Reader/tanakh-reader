## Notes

Some of the paragraph divisions are unhelpful. For example, rank 5 produces 
2 Chr 6:1-23. See the chapter for better splittings, e.g. 6:1-11; 6:12-42
Other examples are 1 Kings 21:27 - 22:40; Num 36:1 - Deut 2:1; 

Many instances of book overlap, e.g., Ezra 10:31 - Neh 1:11

Abundant paragraph markers, e.g., Ezra 10 has a marker after almost every verse. 

The hardest passage is Ezra 6:13-18. Why? It is in *Aramaic*. 

Books lacking paragraph markers (for the most part):
* Ruth
* Eccl
* Obadiah
* Psalms
* Prov

## TODO
Options
* Determine a better method for discovering pericopes.
* Continued use of paragraph markers.

Changes needed to the paragraph parser, *get_paragraphs()* (DONE):
* Check if the verse is a book-end, if so then end the passage.
* Cut the Psalms in chapters; Ps 119 into 8vs sections (for loop with i % 8 = 0).

Cleanup 
* Go to output and if a passage is > *x* words, split it up manually and get the weights of the new items, then update the table. 
