from nltk import *

# Gramatica especifica para a seguinte frase
string = "Live coding is an improvisatory artistic technique"
tokens = pos_tag(word_tokenize(string))

# Noun Phrase: Determinante (?) + adjetivo + substantivo
grammar = "NP: {<DT>?<JJ>*<NN>}"
chunker = RegexpParser(grammar)
result = chunker.parse(tokens)
result.draw()
